package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import com.example.boardserver.entity.*
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.*
import com.example.boardserver.utils.FilterUtils
import com.example.boardserver.utils.runWithTracing
import io.grpc.Context
import io.opentelemetry.api.trace.Tracer
import io.opentelemetry.extension.kotlin.asContextElement
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.domain.Specification


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class AdService(
    private val adRepository: AdRepository,
    private val userRepository: UserRepository,
    private val imageRepository: ImageRepository,
    private val favRepository: FavoritesRepository,
    private val chatRepository: ChatRepository,
    private val messageRepository: MessageRepository,
    private val tracer: Tracer
) : board.AdAPIGrpcKt.AdAPICoroutineImplBase() {

    override suspend fun getManyAd(request: AdOuterClass.GetManyAdRequest): AdOuterClass.PaginatedAd =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetManyAd).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current())
                    val userIdL = userId.toLong()
                    var favs: List<Favorites> = emptyList()
                    val pagingSort: Pageable = PageRequest.of(request.page, request.limit)
                    if (userId != "") {
                        favs = favRepository.findByUserId(userIdL)
                    }
                    val adPage = adRepository.findAll(
                        Specification.where(FilterUtils.adSpecification(request, favs)), pagingSort
                    )
                    val total = adRepository.count()
                    val pageCount = total / request.limit + 1
                    val ads = mutableListOf<AdOuterClass.Ad>()
                    adPage.forEach { ad ->
                        ads.add(
                            ad.toAdPreview(
                                if (userId != "") favRepository.countByUserIdAndAdId(userIdL, ad.id) > 0
                                else false,
                            )
                        )
                    }
                    val response =
                        AdOuterClass.PaginatedAd.newBuilder().addAllData(ads).setCount(ads.size.toLong())
                            .setTotal(total)
                            .setPage(request.page).setPageCount(pageCount).build()
                    response.also { it ->
                        log.info("got page of ads: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun getOneAd(request: AdOuterClass.GetByIdRequest): AdOuterClass.Ad =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetAd).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current())
                    val userIdL = userId.toLong()
                    val ad = adRepository.findById(request.id).get()
                    val images = imageRepository.findAllIdsByAdId(request.id)
                    if (ad.user.id != userIdL && userId != "") {
                        ad.views++
                        adRepository.save(ad)
                    }
                    val response = ad.toAdGrpc(
                        if (userId != "") favRepository.countByUserIdAndAdId(userIdL, ad.id) == 1L
                        else false,
                        images
                    )
                    response.also { it ->
                        log.info("got one ad: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun setFavoriteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(SetFavoriteAds).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    val response: UserOuterClass.IsSuccess =
                        if (favRepository.countByUserIdAndAdId(userId, request.id) == 0L) {
                            val user = userRepository.findById(userId).get()
                            val ad = adRepository.findById(request.id).get()
                            favRepository.save(
                                Favorites(
                                    user = user,
                                    ad = ad,
                                )
                            )
                            UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
                        } else {
                            favRepository.delete(favRepository.findByAdIdAndUserId(request.id, userId).get())
                            UserOuterClass.IsSuccess.newBuilder().setLogin(false).build()
                        }
                    response.also { it ->
                        log.info("ad set as favorite: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun addAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(AddAd).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val ad = request.ad.fromAdGrpc()
                    adRepository.save(ad)
                    val images = request.imagesList.fromImageGrpcList(ad)
                    images.forEach { imageRepository.save(it) }
                    successGrpc().also { it ->
                        log.info("created ad: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }

        }

    override suspend fun deleteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(DeleteAd).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    favRepository.deleteAllByAdId(request.id)
                    imageRepository.deleteAllByAdId(request.id)
                    val chats = chatRepository.findByAdId(request.id)
                    chats.forEach {
                        messageRepository.deleteAllByChatId(it.id)
                        chatRepository.delete(it)
                    }
                    adRepository.deleteById(request.id)
                    successGrpc().also { it ->
                        log.info("ad deleted: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun muteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(MuteAd).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val ad = adRepository.findById(request.id).get()
                    ad.isActive = !ad.isActive
                    adRepository.save(ad)
                    successGrpc().also { it ->
                        log.info("ad muted: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun getFavoriteAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetFavoriteAd).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    val ads = favRepository.findByUserId(userId)
                    ads.toFavRepeatedAdPreviews().also { it ->
                        log.info("got favorite ads: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun getMyAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetMyAd).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    val ads = adRepository.findByUserIdOrderByViewsDesc(userId)
                    ads.toRepeatedMyAd().also { it ->
                        log.info("got my ads: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun getByUserId(request: AdOuterClass.GetByIdRequest): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetByUserId).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val ads = adRepository.findByUserId(request.id)
                    ads.toRepeatedAdGrpc().also { it ->
                        log.info("got user ads: $it").also { span.setAttribute("response", it.toString()) }
                    }
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