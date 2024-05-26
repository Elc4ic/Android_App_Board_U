package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.CategoryRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.AdUtils
import com.example.boardserver.utils.JwtProvider
import io.grpc.Status
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Pageable


@GrpcService
class AdService(
    private val adRepository: AdRepository,
    private val userRepository: UserRepository,
    private val categoryRepository: CategoryRepository,
    private val jwtProvider: JwtProvider,
) : board.AdAPIGrpc.AdAPIImplBase() {

    override fun getManyAd(
        request: AdOuterClass.GetManyAdRequest?,
        responseObserver: StreamObserver<AdOuterClass.PaginatedAd>?
    ) {
        val pagingSort: Pageable = PageRequest.of(request!!.page.toInt(), request.limit.toInt())
        val adPage = adRepository.findAll(pagingSort)
        val total = adRepository.count()
        val pageCount = total / request.limit + 1

        responseObserver?.onNext(
            AdUtils.toPaginatedAdGrpc(adPage.content, request.page, total, pageCount)
        )
        responseObserver?.onCompleted()
    }

    override fun getOneAd(request: AdOuterClass.GetByIdRequest, responseObserver: StreamObserver<AdOuterClass.Ad>?) {
        val ad = adRepository.findById(request.id).get()
        responseObserver?.onNext(AdUtils.toAdGrpc(ad))
        responseObserver?.onCompleted()
    }

    override fun setFavoriteAd(
        request: AdOuterClass.SetFavoriteRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val user = userRepository.findById(userId).get()
            val ad = adRepository.findById(request.id).get()
            if (user.fav_ads.contains(ad)) {
                user.deleteFavAd { ad }
            } else {
                user.addFavAd { ad }
            }

            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
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
            adRepository.save(AdUtils.fromAdGrpc(request.ad))
            val user = userRepository.findById(userId).get()
            user.addMyAd { AdUtils.fromAdGrpc(request.ad) }

            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun deleteAd(
        request: AdOuterClass.ChangeAdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
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
            val user = userRepository.findById(userId).get()
            responseObserver!!.onNext(AdUtils.toRepeatedAdGrpc(user.fav_ads))
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
            val user = userRepository.findByUsername(request.token).get()
            responseObserver!!.onNext(AdUtils.toRepeatedAdGrpc(user.my_ads))
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

}