package com.example.boardserver.delivery.grpc

import board.AdOuterClass
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.successGrpc
import com.example.boardserver.entity.uuid
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.service.AdService
import com.example.boardserver.utils.runWithTracing
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.transaction.annotation.Transactional


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class AdServiceGrpc(
    private val adService: AdService,
    private val tracer: Tracer
) : board.AdAPIGrpcKt.AdAPICoroutineImplBase() {

    override suspend fun getManyAd(request: AdOuterClass.GetManyAdRequest): AdOuterClass.PaginatedAd =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetManyAd) {
                adService.getManyAd(request)
            }
        }

    @Transactional
    override suspend fun getOneAd(request: AdOuterClass.GetByIdWithBoolRequest): AdOuterClass.Ad =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetAd) {
               adService.getOneAd(request.id.uuid(), request.value)
            }
        }


    @Transactional
    override suspend fun setFavoriteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, SetFavoriteAds) {
                adService.setFavoriteAd(request.id.uuid()).let { successGrpc(it) }
            }
        }

    @Transactional
    override suspend fun addAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, AddAd) {
               adService.addAd(request.ad, request.imagesList).let { successGrpc(it) }
            }
        }

    @Transactional
    override suspend fun editAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, AddAd) {
                adService.editAd(request.ad,request.imagesList).let { successGrpc(it) }
            }
        }

    @Transactional
    override suspend fun deleteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteAd) {
                adService.deleteAd(request.id.uuid()).let { successGrpc(it) }
            }
        }


    @Transactional
    override suspend fun muteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, MuteAd) {
                adService.muteAd(request.id.uuid()).let { successGrpc(it) }
            }
        }


    override suspend fun getFavoriteAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetFavoriteAd) {
              adService.getFavoriteAds()
            }
        }


    override suspend fun getMyAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetMyAd) {
                adService.getMyAds()
            }
        }


    override suspend fun getByUserId(request: AdOuterClass.GetByIdRequest): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetByUserId) {
                adService.getByUserId(request.id.uuid())
            }
        }

    companion object {
        private val log = LoggerFactory.getLogger(AdServiceGrpc::class.java)
        private const val timeOutMillis = 5000L

        private const val adService = "AdAPI"
        private const val GetManyAd = "${adService}.getManyAd"
        private const val GetAd = "${adService}.getAd"
        private const val AddAd = "${adService}.addAd"
        private const val DeleteAd = "${adService}.deleteAd"
        private const val SetFavoriteAds = "${adService}.setFavoriteAds"
        private const val GetFavoriteAd = "${adService}.getFavoriteAd"
        private const val GetMyAd = "${adService}.getMyAd"
        private const val GetByUserId = "${adService}.getByUserId"
        private const val MuteAd = "${adService}.muteAd"
    }
}