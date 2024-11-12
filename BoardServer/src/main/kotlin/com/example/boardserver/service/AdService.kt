package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.*
import com.example.boardserver.exceptions.NotFoundException
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.FilterUtils
import com.example.boardserver.utils.runWithTracing
import io.grpc.Context
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.domain.Specification
import org.springframework.transaction.annotation.Transactional


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class AdService(
    private val adRepository: AdRepository,
    private val userRepository: UserRepository,
    private val tracer: Tracer
) : board.AdAPIGrpcKt.AdAPICoroutineImplBase() {

    override suspend fun getManyAd(request: AdOuterClass.GetManyAdRequest): AdOuterClass.PaginatedAd =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetManyAd) {
                val isAuth = ContextKeys.AUTH_KEY.get(Context.current()).toBoolean()
                var favs: List<Ad> = emptyList()
                val pagingSort: Pageable = PageRequest.of(request.page, request.limit)
                if (isAuth) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                    favs = userRepository.findFavsByUserId(userId)
                }
                val adPage = adRepository.findAll(
                    Specification.where(FilterUtils.adSpecification(request, favs)), pagingSort
                )
                adPage.toPagedAdPreview(favs).also { log.info("getManyAd: $it") }
            }
        }

    @Transactional
    override suspend fun getOneAd(request: AdOuterClass.GetByIdWithBoolRequest): AdOuterClass.Ad =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetAd) {
                var isFav = false
                val isAuth = ContextKeys.AUTH_KEY.get(Context.current()).toBoolean()
                val ad = adRepository.findAdWithImages(request.id.uuid()).orElseThrow()
                if (isAuth) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                    isFav = adRepository.existsFavByUserIdAndAdId(ad.id, userId)
                    if(!request.value) ad.views++
                    adRepository.save(ad)
                }
                val response = ad.toAdGrpc(isFav)
                response
            }
        }


    @Transactional
    override suspend fun setFavoriteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, SetFavoriteAds, log) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val adId = request.id.uuid()
                val user = userRepository.findUserWithFavs(userId).orElseThrow { NotFoundException("Пользователь") }
                val ad = adRepository.findAdWithFavs(adId).orElseThrow { NotFoundException("Объявление") }
                user.addOrRemoveFav(ad)
                userRepository.save(user)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun addAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, AddAd, log) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val user = userRepository.findUserWithAds(userId).orElseThrow()
                val ad = request.ad.fromAdGrpc(true)
                request.imagesList.forEach { image -> ad.updateImage(image.fromImageGrpc(ad)) }
                user.addAd(ad)
                userRepository.save(user)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun editAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, AddAd) {
                val ad = adRepository.findAdWithImages(request.ad.id.uuid())
                    .orElseThrow()
                ad.title = request.ad.title
                ad.description = request.ad.description
                ad.price = request.ad.price
                ad.category = request.ad.category.fromCategoryGrpc()
                ad.images.clear()
                request.imagesList.forEach { image -> ad.updateImage(image.fromImageGrpc(ad)) }
                adRepository.save(ad)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun deleteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteAd) {
                adRepository.deleteById(request.id.uuid())
                successGrpc()
            }
        }


    @Transactional
    override suspend fun muteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, MuteAd) {
                val ad = adRepository.findById(request.id.uuid()).orElseThrow()
                ad.isActive = !ad.isActive
                adRepository.save(ad)
                successGrpc()
            }
        }


    override suspend fun getFavoriteAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetFavoriteAd) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val ads = userRepository.findFavsByUserId(userId)
                ads.toRepeatedAdGrpc(true)
            }
        }


    override suspend fun getMyAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetMyAd, log) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val ads = adRepository.findByUserIdOrderByViewsDesc(userId)
                ads.toRepeatedMyAd()
            }
        }


    override suspend fun getByUserId(request: AdOuterClass.GetByIdRequest): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetByUserId) {
                val ads = adRepository.findByUserId(request.id.uuid())
                ads.toRepeatedAdGrpc()
            }
        }

    companion object {
        private val log = LoggerFactory.getLogger(AdService::class.java)
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