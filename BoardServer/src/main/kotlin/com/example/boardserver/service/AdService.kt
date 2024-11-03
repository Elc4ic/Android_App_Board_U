package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.*
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.FavoritesRepository
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
    private val favRepository: FavoritesRepository,
    private val tracer: Tracer
) : board.AdAPIGrpcKt.AdAPICoroutineImplBase() {

    override suspend fun getManyAd(request: AdOuterClass.GetManyAdRequest): AdOuterClass.PaginatedAd =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetManyAd)
            runWithTracing(span) {
                val isAuth = ContextKeys.AUTH_KEY.get(Context.current()).toBoolean()
                var favs: List<Favorites> = emptyList()
                val pagingSort: Pageable = PageRequest.of(request.page, request.limit)
                if (isAuth) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                    favs = favRepository.findByUserId(userId)
                }
                val adPage = adRepository.findAll(
                    Specification.where(FilterUtils.adSpecification(request, favs)), pagingSort
                )
                val total = adRepository.count()
                val pageCount = total / request.limit + 1

                adPage.toPagedAdPreview(request, favs, total, pageCount).also { it ->
                    log.info("got page of ads: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getOneAd(request: AdOuterClass.GetByIdRequest): AdOuterClass.Ad =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetAd)
            runWithTracing(span) {
                var isFav = false
                val isAuth = ContextKeys.AUTH_KEY.get(Context.current()).toBoolean()
                val ad = adRepository.findById(request.id.uuid()).get()

                if (isAuth) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                    isFav = favRepository.existsByUserIdAndAdId(userId, ad.id!!)
                    ad.views++
                    adRepository.save(ad)
                }
                val response = ad.toAdGrpc(isFav)
                response.also { it ->
                    log.info("got one ad: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    @Transactional
    override suspend fun setFavoriteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(SetFavoriteAds)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                if (favRepository.existsByUserIdAndAdId(userId, request.id.uuid())) {
                    val user = userRepository.findById(userId).get()
                    val ad = adRepository.findById(request.id.uuid()).get()
                    val fav = Favorites(user = user, ad = ad)
                    user.addFav(fav)
                    userRepository.save(user)
                } else {
                    val fav = favRepository.findByAdIdAndUserId(request.id.uuid(), userId).get()
                    favRepository.delete(fav)
                }
                successGrpc().also { it ->
                    log.info("ad set as favorite: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    @Transactional
    override suspend fun addAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(AddAd)
            runWithTracing(span) {
                val ad = request.ad.fromAdGrpc()
                ad.images = request.imagesList.fromImageGrpcList(ad)
                adRepository.save(ad)
                successGrpc().also { it ->
                    log.info("created ad: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun deleteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteAd)
            runWithTracing(span) {
                favRepository.deleteAllByAdId(request.id.uuid())
                adRepository.deleteById(request.id.uuid())
                successGrpc().also { it ->
                    log.info("ad deleted: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    @Transactional
    override suspend fun muteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(MuteAd)
            runWithTracing(span) {
                val ad = adRepository.findById(request.id.uuid()).get()
                ad.isActive = !ad.isActive
                adRepository.save(ad)
                successGrpc().also { it ->
                    log.info("ad muted: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getFavoriteAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetFavoriteAd)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val ads = favRepository.findByUserId(userId)
                ads.toFavRepeatedAdPreviews().also { it ->
                    log.info("got favorite ads: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getMyAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetMyAd)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val ads = adRepository.findByUserIdOrderByViewsDesc(userId)
                ads.toRepeatedMyAd().also { it ->
                    log.info("got my ads: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getByUserId(request: AdOuterClass.GetByIdRequest): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetByUserId)
            runWithTracing(span) {
                val ads = adRepository.findByUserId(request.id.uuid())
                ads.toRepeatedAdGrpc().also { it ->
                    log.info("got user ads: $it").also { span.tag("response", it.toString()) }
                }
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