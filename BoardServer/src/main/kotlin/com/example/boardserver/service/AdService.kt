package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.CategoryRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.AdUtils
import com.example.boardserver.utils.JwtProvider
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
        val ad = request.let { adRepository.findById(it.id) }
        responseObserver?.onNext(ad.let { AdUtils.toAdGrpc(it.get()) })
        responseObserver?.onCompleted()
    }

    override fun setFavoriteAd(
        request: AdOuterClass.SetFavoriteRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val user = userRepository.findByToken(request!!.token).get()
        val ad = adRepository.findById(request.id).get()
        if (user.fav_ads.contains(ad)) {
            user.deleteFavAd { ad }
        } else {
            user.addFavAd { ad }
        }
        responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
        responseObserver?.onCompleted()
    }

    override fun addAd(
        request: AdOuterClass.ChangeAdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        if (request!!.token == null) {
            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(false).build())
        } else {
            adRepository.save(AdUtils.fromAdGrpc(request.ad))
            val user = userRepository.findByToken(request.token).get()
            user.addMyAd { AdUtils.fromAdGrpc(request.ad) }
            responseObserver?.onNext(UserOuterClass.IsSuccess.newBuilder().setLogin(true).build())
        }
        responseObserver?.onCompleted()
    }

    override fun deleteAd(
        request: AdOuterClass.ChangeAdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        adRepository.delete(AdUtils.fromAdGrpc(request!!.ad))
    }

    override fun muteAd(
        request: AdOuterClass.ChangeAdRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        adRepository.save(AdUtils.fromAdGrpcMute(request!!.ad))
    }

    override fun getFavoriteAds(
        request: UserOuterClass.TokenProto?,
        responseObserver: StreamObserver<AdOuterClass.RepeatedAdResponse>?
    ) {
        val user = userRepository.findByToken(request!!.token).get()
        responseObserver!!.onNext(AdUtils.toRepeatedAdGrpc(user.fav_ads))
        responseObserver.onCompleted()
    }

    override fun getMyAds(
        request: UserOuterClass.TokenProto?,
        responseObserver: StreamObserver<AdOuterClass.RepeatedAdResponse>?
    ) {
        val user = userRepository.findByToken(request!!.token).get()
        responseObserver!!.onNext(AdUtils.toRepeatedAdGrpc(user.my_ads))
        responseObserver.onCompleted()
    }


}