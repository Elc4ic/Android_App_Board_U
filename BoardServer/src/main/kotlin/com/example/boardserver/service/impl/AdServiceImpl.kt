package com.example.boardserver.service.impl

import board.AdOuterClass
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.*
import com.example.boardserver.exceptions.Errors
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.service.AdService
import com.example.boardserver.utils.FilterUtils
import com.example.boardserver.utils.runWithTracing
import io.grpc.Context
import org.slf4j.LoggerFactory
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.domain.Specification
import org.springframework.stereotype.Service
import java.util.*


@Service
class AdServiceImpl(
    private val adRepository: AdRepository,
    private val userRepository: UserRepository,
    private val tracer: Tracer
): AdService {

    override suspend fun getManyAd(request: AdOuterClass.GetManyAdRequest): AdOuterClass.PaginatedAd =
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
            adPage.toPagedAdPreview(favs)
        }


    override suspend fun getOneAd(id: UUID, viewed: Boolean): AdOuterClass.Ad =
        runWithTracing(tracer, GetAd) {
            var isFav = false
            val isAuth = ContextKeys.AUTH_KEY.get(Context.current()).toBoolean()
            val ad = adRepository.findAdWithImages(id).orElseThrow()
            if (isAuth) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                isFav = adRepository.existsFavByUserIdAndAdId(ad.id, userId)
                if (!viewed) ad.views++
                adRepository.save(ad)
            }
            val response = ad.toAdGrpc(isFav)
            response
        }


    override suspend fun setFavoriteAd(id:UUID): Boolean =
        runWithTracing(tracer, SetFavoriteAds) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val adId = id
            val user = userRepository.findUserWithFavs(userId).orElseThrow { Errors.NotFoundUser() }
            val ad = adRepository.findAdWithFavs(adId).orElseThrow { Errors.NotFoundAd() }
            user.addOrRemoveFav(ad)
            userRepository.save(user)
            true
        }


    override suspend fun addAd(adGrpc:AdOuterClass.Ad, images: List<UserOuterClass.ImageProto>): Boolean =
        runWithTracing(tracer, AddAd) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val user = userRepository.findUserWithAds(userId).orElseThrow()
            val ad = adGrpc.fromAdGrpc(true)
            images.forEach { image -> ad.updateImage(image.fromImageGrpc(ad)) }
            user.addAd(ad)
            userRepository.save(user)
            true
        }


    override suspend fun editAd(adGrpc: AdOuterClass.Ad, images: List<UserOuterClass.ImageProto>): Boolean =
        runWithTracing(tracer, AddAd) {
            val ad = adRepository.findAdWithImages(adGrpc.id.uuid()).orElseThrow()
            ad.title = adGrpc.title
            ad.description = adGrpc.description
            ad.price = adGrpc.price
            ad.category = adGrpc.category.fromCategoryGrpc()
            ad.images.clear()
            images.forEach { image -> ad.updateImage(image.fromImageGrpc(ad)) }
            adRepository.save(ad)
            true
        }


    override suspend fun deleteAd(id:UUID): Boolean =
        runWithTracing(tracer, DeleteAd) {
            adRepository.deleteById(id)
            true
        }


    override suspend fun muteAd(id: UUID): Boolean =
        runWithTracing(tracer, MuteAd) {
            val ad = adRepository.findById(id).orElseThrow()
            ad.isActive = !ad.isActive
            adRepository.save(ad)
            true
        }


    override suspend fun getFavoriteAds(): AdOuterClass.RepeatedAdResponse =
        runWithTracing(tracer, GetFavoriteAd) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val ads = userRepository.findFavsByUserId(userId)
            ads.toRepeatedAdGrpc(true)
        }


    override suspend fun getMyAds(): AdOuterClass.RepeatedAdResponse =
        runWithTracing(tracer, GetMyAd) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val ads = adRepository.findByUserIdOrderByViewsDesc(userId)
            ads.toRepeatedMyAd()
        }


    override suspend fun getByUserId(id:UUID): AdOuterClass.RepeatedAdResponse =
        runWithTracing(tracer, GetByUserId) {
            val ads = adRepository.findByUserId(id)
            ads.toRepeatedAdGrpc()
        }


    companion object {
        private val log = LoggerFactory.getLogger(AdServiceImpl::class.java)

        private const val adService = "AdService"
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