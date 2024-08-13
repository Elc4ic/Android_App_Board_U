package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import com.example.boardserver.entity.Favorites
import com.example.boardserver.repository.*
import com.example.boardserver.utils.AdUtils
import com.example.boardserver.utils.FilterUtils
import com.example.boardserver.utils.ImageUtils
import com.example.boardserver.utils.JwtProvider
import com.google.protobuf.kotlin.toByteString
import io.grpc.Status
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.domain.Specification
import org.springframework.transaction.annotation.Transactional


@GrpcService
class AdService(
    private val adRepository: AdRepository,
    private val userRepository: UserRepository,
    private val imageRepository: ImageRepository,
    private val jwtProvider: JwtProvider,
    private val favRepository: FavoritesRepository,
    private val chatRepository: ChatRepository,
    private val messageRepository: MessageRepository
) : board.AdAPIGrpc.AdAPIImplBase() {

    override fun getManyAd(
        request: AdOuterClass.GetManyAdRequest?,
        responseObserver: StreamObserver<AdOuterClass.PaginatedAd>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        val pagingSort: Pageable = PageRequest.of(request.page.toInt(), request.limit.toInt())

        val adPage = adRepository.findAll(
            Specification.where(FilterUtils.adSpecification(request)),
            pagingSort
        )
        val total = adRepository.count()
        val pageCount = total / request.limit + 1
        val ads = mutableListOf<AdOuterClass.Ad>()
        adPage.forEach { ad ->
            ads.add(
                AdUtils.toAdGrpc(
                    ad,
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
        val userId = jwtProvider.validateJwt(request.token)
        val ad = adRepository.findById(request.id).get()
        if (ad.user.id != userId) {
            ad.views++
            adRepository.save(ad)
        }
        responseObserver?.onNext(
            AdUtils.toAdGrpc(
                ad,
                if (userId != null) favRepository.countByUserIdAndAdId(userId, ad.id) == 1L
                else false,
            )
        )
        responseObserver?.onCompleted()
    }

    override fun loadImage(
        request: AdOuterClass.GetByIdWithBoolRequest?,
        responseObserver: StreamObserver<AdOuterClass.RepeatedImageResponse>?
    ) {
        if (request?.value == true) {
            val image = imageRepository.findFirstByAdId(request.id).get()
            responseObserver?.onNext(ImageUtils.toImageGrpcList(listOf(image)))
        } else {
            val images = imageRepository.findByAdId(request!!.id)
            responseObserver?.onNext(ImageUtils.toImageGrpcList(images))
        }
        responseObserver?.onCompleted()
    }

    override fun setFavoriteAd(
        request: AdOuterClass.GetByIdRequest?,
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

    @Transactional
    override fun addAd(
        request: AdOuterClass.ChangeAdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val ad = AdUtils.fromAdGrpc(request.ad)
            adRepository.save(ad)
            val images = ImageUtils.fromImageGrpcList(request.imagesList, ad)
            images.forEach { image -> println("${image.imageBytes.toByteString()}") }
            images.forEach { imageRepository.save(it) }
            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun deleteAd(
        request: AdOuterClass.GetByIdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            favRepository.deleteAllByAdId(request.id)
            imageRepository.deleteByAdId(request.id)
            val chats = chatRepository.findByAdId(request.id)
            chats.forEach {
                messageRepository.deleteAllByChatId(it.id);
                chatRepository.delete(it)
            }
            adRepository.deleteById(request.id)
            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun muteAd(
        request: AdOuterClass.GetByIdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val ad = adRepository.findById(request.id).get();
            ad.isActive = !ad.isActive;
            adRepository.save(ad)
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
            responseObserver?.onNext(AdUtils.toRepeatedAdGrpc(ads))
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun getByUserId(
        request: AdOuterClass.GetByIdRequest?,
        responseObserver: StreamObserver<AdOuterClass.RepeatedAdResponse>?
    ) {
        val ads = adRepository.findByUserId(request!!.id)
        responseObserver?.onNext(AdUtils.toRepeatedAdGrpc(ads))
        responseObserver?.onCompleted()
    }
}