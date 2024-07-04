package com.example.boardserver.utils

import board.AdOuterClass
import com.example.boardserver.entity.Ad
import com.example.boardserver.entity.Favorites
import com.example.boardserver.entity.Image
import com.example.boardserver.utils.CategoryUtils.fromCategoryGrpc
import com.example.boardserver.utils.CategoryUtils.toCategoryGrpc
import com.example.boardserver.utils.UserUtils.fromUserGrpc

object AdUtils {
    fun fromAdGrpc(ad: AdOuterClass.Ad): Ad {
        return Ad(
            id = ad.id,
            title = ad.title,
            price = ad.price,
            description = ad.description,
            isActive = ad.isActive,
            views = ad.views,
            created = ad.created,
            user = fromUserGrpc(ad.user),
            category = fromCategoryGrpc(ad.category),
        )
    }

    fun toAdGrpc(ad: Ad, isFav: Boolean = false): AdOuterClass.Ad {
        return AdOuterClass.Ad.newBuilder()
            .setId(ad.id)
            .setTitle(ad.title)
            .setPrice(ad.price)
            .setDescription(ad.description)
            .setIsFav(isFav)
            .setIsActive(ad.isActive)
            .setViews(ad.views)
            .setCreated(ad.created)
            .setUser(UserUtils.toUserGrpc(ad.user))
            .setCategory(toCategoryGrpc(ad.category))
            .build()
    }

    fun toRepeatedAdGrpc(adPage: List<Ad>): AdOuterClass.RepeatedAdResponse {
        val ads = mutableListOf<AdOuterClass.Ad>()
        adPage.forEach { ad -> ads.add(toAdGrpc(ad)) }
        return AdOuterClass.RepeatedAdResponse.newBuilder()
            .addAllData(ads)
            .build()
    }

    fun toFavRepeatedAdGrpc(favorites: List<Favorites>): AdOuterClass.RepeatedAdResponse {
        val ads = mutableListOf<AdOuterClass.Ad>()
        favorites.forEach { fav -> ads.add(toAdGrpc(fav.ad)) }
        return AdOuterClass.RepeatedAdResponse.newBuilder()
            .addAllData(ads)
            .build()
    }
}