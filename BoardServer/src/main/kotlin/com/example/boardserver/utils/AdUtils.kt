package com.example.boardserver.utils

import board.AdOuterClass
import com.example.boardserver.entity.Ad
import com.example.boardserver.utils.CategoryUtils.fromCategoryGrpc
import com.example.boardserver.utils.UserUtils.fromUserGrpc

object AdUtils {
    fun fromAdGrpc(ad: AdOuterClass.Ad): Ad {
        return Ad(
            id = ad.id,
            title = ad.title,
            price = ad.price,
            description = ad.description,
            views = ad.views,
            created = ad.created,
            user = fromUserGrpc(ad.user),
            category = fromCategoryGrpc(ad.category),
        )
    }

    fun fromAdGrpcMute(ad: AdOuterClass.Ad): Ad {
        return Ad(
            id = ad.id,
            title = ad.title,
            price = ad.price,
            description = ad.description,
            views = ad.views,
            is_active = !ad.isActive,
            created = ad.created,
            user = fromUserGrpc(ad.user),
            category = fromCategoryGrpc(ad.category),
        )
    }

    fun toAdGrpc(ad: Ad): AdOuterClass.Ad {
        return AdOuterClass.Ad.newBuilder()
            .setId(ad.id)
            .setTitle(ad.title)
            .setPrice(ad.price)
            .setDescription(ad.description)
            .setIsActive(ad.is_active)
            .setViews(ad.views)
            .setCreated(ad.created)
            .build()
    }

    fun toPaginatedAdGrpc(adPage: List<Ad>, page: Long, total: Long, pageCount: Long): AdOuterClass.PaginatedAd {
        val ads = mutableListOf<AdOuterClass.Ad>()
        adPage.forEach { ad -> ads.add(toAdGrpc(ad)) }
        return AdOuterClass.PaginatedAd.newBuilder()
            .addAllData(ads)
            .setCount(ads.size.toLong())
            .setTotal(total)
            .setPage(page)
            .setPageCount(pageCount)
            .build()
    }

    fun toRepeatedAdGrpc(adPage: List<Ad>): AdOuterClass.RepeatedAdResponse {
        val ads = mutableListOf<AdOuterClass.Ad>()
        adPage.forEach { ad -> ads.add(toAdGrpc(ad)) }
        return AdOuterClass.RepeatedAdResponse.newBuilder()
            .addAllData(ads)
            .build()
    }

}