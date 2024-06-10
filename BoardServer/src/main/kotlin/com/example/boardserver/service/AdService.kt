package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import com.example.boardserver.entity.Favorites
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.FavoritesRepository
import com.example.boardserver.repository.ImageRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.AdUtils
import com.example.boardserver.utils.ImageUtils
import com.example.boardserver.utils.JwtProvider
import io.grpc.Status
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Pageable
import org.springframework.transaction.annotation.Transactional


@GrpcService
class AdService(
    private val adRepository: AdRepository,
    private val userRepository: UserRepository,
    private val imageRepository: ImageRepository,
    private val jwtProvider: JwtProvider,
    private val favRepository: FavoritesRepository,
) : board.AdAPIGrpc.AdAPIImplBase() {

    override fun getManyAd(
        request: AdOuterClass.GetManyAdRequest?,
        responseObserver: StreamObserver<AdOuterClass.PaginatedAd>?
    ) {

        val userId = jwtProvider.validateJwt(request!!.token)
        val pagingSort: Pageable = PageRequest.of(request!!.page.toInt(), request.limit.toInt())
        val adPage = adRepository.findAllByIsActive(pagingSort, true)
        val total = adRepository.count()
        val pageCount = total / request.limit + 1
        val ads = mutableListOf<AdOuterClass.Ad>()
        adPage.forEach { ad ->
            ads.add(
                AdUtils.toAdGrpcWithImages(
                    ad,
                    imageRepository.findByAdId(ad.id),
                    if (userId != null) favRepository.countByUserIdAndAdId(userId, ad.id) == 1L
                    else false,
                )
            )
        }
        val response = AdOuterClass.PaginatedAd.newBuilder()
            .addAllData(ads)
            .setCount(ads.size.toLong())
            .setTotal(total)
            .setPage(request.page)
            .setPageCount(pageCount)
            .build()
        responseObserver?.onNext(response)
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun getOneAd(request: AdOuterClass.GetByIdRequest, responseObserver: StreamObserver<AdOuterClass.Ad>?) {
        val ad = adRepository.findById(request.id).get()
        val images = imageRepository.findByAdId(request.id)
        responseObserver?.onNext(AdUtils.toAdGrpcWithImages(ad, images))
        responseObserver?.onCompleted()
    }

    override fun setFavoriteAd(
        request: AdOuterClass.SetFavoriteRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            if (favRepository.countByUserIdAndAdId(userId, request.id) == 0L) {
                val user = userRepository.findById(userId).get()
                val ad = adRepository.findById(request.id).get()
                favRepository.save(
                    Favorites(
                        user = user,
                        ad = ad,
                    )
                )
                responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
            } else {
                favRepository.delete(favRepository.findByAdIdAndUserId(request.id, userId).get())
                responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(false).build())
            }
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun addAd(
        request: AdOuterClass.ChangeAdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val ad = AdUtils.fromAdGrpc(request.ad)
            adRepository.save(ad)
            request.ad.imagesList.forEach { image -> println("${image.image} ${image.image.size()}") }
            val images = ImageUtils.fromAdGrpcList(request.ad.imagesList, ad)
            images.forEach { imageRepository.save(it) }
            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun deleteAd(
        request: AdOuterClass.ChangeAdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            imageRepository.deleteByAdId(request.ad.id)
            adRepository.delete(AdUtils.fromAdGrpc(request.ad))

            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun muteAd(
        request: AdOuterClass.ChangeAdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            adRepository.save(AdUtils.fromAdGrpcMute(request.ad))
            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun getFavoriteAds(
        request: UserOuterClass.JwtProto?,
        responseObserver: StreamObserver<AdOuterClass.RepeatedAdResponse>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val ads = favRepository.findByUserId(userId)
            responseObserver!!.onNext(AdUtils.toFavRepeatedAdGrpc(ads))
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun getMyAds(
        request: UserOuterClass.JwtProto?,
        responseObserver: StreamObserver<AdOuterClass.RepeatedAdResponse>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val ads = adRepository.findByUserId(userId)
            responseObserver!!.onNext(AdUtils.toRepeatedAdGrpc(ads))
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

}