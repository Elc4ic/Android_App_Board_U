package com.example.boardserver.delivery.grpc

import board.AdOuterClass
import board.UserOuterClass
import board.UserOuterClass.IsSuccess
import brave.Tracer
import com.example.boardserver.entity.successGrpc
import com.example.boardserver.entity.uuid
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.service.AdService
import com.example.boardserver.utils.runWithTracing
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class AdServiceGrpc(
    private val adService: AdService,
    private val tracer: Tracer
) : board.AdAPIGrpcKt.AdAPICoroutineImplBase() {

    override suspend fun getManyAd(request: AdOuterClass.GetManyAdRequest): AdOuterClass.PaginatedAd =

        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetManyAd)
            runWithTracing(span ) {
                adService.getManyAd(request).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun getOneAd(request: AdOuterClass.GetByIdWithBoolRequest): AdOuterClass.Ad =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetAd)
            runWithTracing(span ) {
                adService.getOneAd(request.id.uuid(), request.value).also { span.tag("response", it.toString()) }
            }
        }


    override suspend fun setFavoriteAd(request: AdOuterClass.GetByIdRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(SetFavoriteAds)
            runWithTracing(span ) {
                adService.setFavoriteAd(request.id.uuid()).let { successGrpc(it) }.also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun addAd(request: AdOuterClass.ChangeAdRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan( AddAd)
            runWithTracing(span) {
                adService.addAd(request.ad, request.imagesList).let{ successGrpc(it) }.also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun deleteAd(request: AdOuterClass.GetByIdRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan( DeleteAd)
            runWithTracing(span) {
                adService.deleteAd(request.id.uuid()).let { successGrpc(it) }.also { span.tag("response", it.toString()) }
            }
        }


    override suspend fun muteAd(request: AdOuterClass.GetByIdRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(MuteAd)
            runWithTracing(span ) {
                adService.muteAd(request.id.uuid()).let { successGrpc(it) }.also { span.tag("response", it.toString()) }
            }
        }


    override suspend fun getFavoriteAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan( GetFavoriteAd)
            runWithTracing(span) {
                adService.getFavoriteAds().also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun getMyAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetMyAd)
            runWithTracing(span ) {
                adService.getMyAds().also { span.tag("response", it.toString()) }
            }
        }


    override suspend fun getByUserId(request: AdOuterClass.GetByIdRequest): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan( GetByUserId)
            runWithTracing(span) {
                adService.getByUserId(request.id.uuid()).also { span.tag("response", it.toString()) }
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
        private const val UpdateFavoriteAd = "${adService}.updateFavoriteAd"
        private const val GetMyAd = "${adService}.getMyAd"
        private const val GetByUserId = "${adService}.getByUserId"
        private const val MuteAd = "${adService}.muteAd"
    }
}