package com.example.boardserver.service

import board.AdOuterClass
import board.AdOuterClass.RepeatedImageResponse
import board.UserOuterClass
import com.example.boardserver.entity.*
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.*
import com.example.boardserver.utils.FilterUtils
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.runWithTracing
import io.grpc.Status
import io.micrometer.tracing.Tracer
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
    private val imageRepository: ImageRepository,
    private val jwtProvider: JwtProvider,
    private val favRepository: FavoritesRepository,
    private val chatRepository: ChatRepository,
    private val messageRepository: MessageRepository,
    private val tracer: Tracer
) : board.AdAPIGrpcKt.AdAPICoroutineImplBase() {

    override suspend fun getManyAd(request: AdOuterClass.GetManyAdRequest): AdOuterClass.PaginatedAd =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetManyAd)
            val userId = jwtProvider.validateJwt(request.token)
            var favs: List<Favorites> = emptyList()
            val pagingSort: Pageable = PageRequest.of(request.page, request.limit)
            if (userId != null) {
                favs = favRepository.findByUserId(userId)
            }
            val adPage = adRepository.findAll(
                Specification.where(FilterUtils.adSpecification(request, favs)), pagingSort
            )
            val total = adRepository.count()
            val pageCount = total / request.limit + 1
            val ads = mutableListOf<AdOuterClass.Ad>()
            adPage.forEach { ad ->
                ads.add(
                    ad.toAdGrpc(
                        if (userId != null) favRepository.countByUserIdAndAdId(userId, ad.id) > 0
                        else false,
                    )
                )
            }
            val response =
                AdOuterClass.PaginatedAd.newBuilder().addAllData(ads).setCount(ads.size.toLong()).setTotal(total)
                    .setPage(request.page).setPageCount(pageCount).build()

            runWithTracing(span) {
                response.also { it ->
                    log.info("got page of ads: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getOneAd(request: AdOuterClass.GetByIdRequest): AdOuterClass.Ad =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetAd)
            val userId = jwtProvider.validateJwt(request.token)
            val ad = adRepository.findById(request.id).get()
            if (ad.user.id != userId) {
                ad.views++
                adRepository.save(ad)
            }
            val response = ad.toAdGrpc(
                if (userId != null) favRepository.countByUserIdAndAdId(userId, ad.id) == 1L
                else false,
            )

            runWithTracing(span) {
                response.also { it ->
                    log.info("got one ad: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    @Transactional
    override suspend fun setFavoriteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(SetFavoriteAds)
            val userId = jwtProvider.validateJwt(request.token)
            val response: UserOuterClass.IsSuccess
            if (userId != null) {
                response = if (favRepository.countByUserIdAndAdId(userId, request.id) == 0L) {
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
                runWithTracing(span) {
                    response.also { it ->
                        log.info("ad set as favorite: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
            }
        }


    @Transactional
    override suspend fun addAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(AddAd)
            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                val ad = request.ad.fromAdGrpc()
                adRepository.save(ad)
                val images = request.imagesList.fromImageGrpcList(ad)
                images.forEach { imageRepository.save(it) }
                val response = UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()

                runWithTracing(span) {
                    response.also { it ->
                        log.info("created ad: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
            }
        }


    @Transactional
    override suspend fun deleteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteAd)
            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                favRepository.deleteAllByAdId(request.id)
                imageRepository.deleteAllByAdId(request.id)
                val chats = chatRepository.findByAdId(request.id)
                chats.forEach {
                    messageRepository.deleteAllByChatId(it.id)
                    chatRepository.delete(it)
                }
                adRepository.deleteById(request.id)
                val response = UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("ad deleted: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
            }
        }

    @Transactional
    override suspend fun muteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(MuteAd)

            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                val ad = adRepository.findById(request.id).get()
                ad.isActive = !ad.isActive
                adRepository.save(ad)
                val response = UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("ad muted: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
            }
        }


    override suspend fun getFavoriteAds(request: UserOuterClass.JwtProto): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetFavoriteAd)

            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                val ads = favRepository.findByUserId(userId)
                val response = ads.toFavRepeatedAdGrpc()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("got favorite ads: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
            }
        }


    override suspend fun getMyAds(request: UserOuterClass.JwtProto): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetMyAd)
            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                val ads = adRepository.findByUserIdOrderByViewsDesc(userId)
                val response = ads.toRepeatedAdGrpc()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("got my ads: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
            }
        }


    override suspend fun getByUserId(request: AdOuterClass.GetByIdRequest): AdOuterClass.RepeatedAdResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetByUserId)
            val ads = adRepository.findByUserId(request.id)
            val response =ads.toRepeatedAdGrpc()

            runWithTracing(span) {
                response.also { it ->
                    log.info("got user ads: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun loadImage(request: AdOuterClass.GetByIdWithBoolRequest): RepeatedImageResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(LoadImages)
            val response: RepeatedImageResponse = try {
                if (request.value) {
                    val image = imageRepository.findFirstByAdId(request.id).get()
                 listOf(image).toImageGrpcList()
                } else {
                    val images = imageRepository.findByAdId(request.id)
                images.toImageGrpcList()
                }
            } catch (e: Exception) {
                emptyList<Image>().toImageGrpcList().also { span.tag("response", it.toString()) }
            }

            runWithTracing(span) {
                response.also { it ->
                    log.info("image loaded: $it").also { span.tag("image", it.toString()) }
                }
            }
        }

    companion object {
        private val log = LoggerFactory.getLogger(AdService::class.java)
        private const val timeOutMillis = 5000L

        private const val GetManyAd = "AdService.getManyAd"
        private const val GetAd = "AdService.getAd"
        private const val AddAd = "AdService.addAd"
        private const val DeleteAd = "AdService.deleteAd"
        private const val SetFavoriteAds = "AdService.setFavoriteAds"
        private const val GetFavoriteAd = "AdService.getFavoriteAd"
        private const val GetMyAd = "AdService.getMyAd"
        private const val GetByUserId = "AdService.getByUserId"
        private const val MuteAd = "AdService.muteAd"
        private const val LoadImages = "AdService.loadImages"
    }
}