package com.example.boardserver.dto

import adProto.AdOuterClass
import com.example.boardserver.entity.Ad
import org.springframework.data.domain.Page

object AdUtils {
    fun fromAdGrpc(ad: AdOuterClass.Ad): Ad {
        return Ad(ad.id, ad.title, ad.price, ad.description, ad.isFavorite, null)
    }

    fun ChangeAdFav(ad: Ad): Ad {
        return Ad(ad.id, ad.title, ad.price, ad.description, !ad.is_favorite, null)
    }

    fun toAdGrpc(ad: Ad): AdOuterClass.Ad {
        return AdOuterClass.Ad.newBuilder()
            .setId(ad.id)
            .setTitle(ad.title)
            .setPrice(ad.price)
            .setDescription(ad.description)
            .setIsFavorite(ad.is_favorite)
            .build()
    }

    fun toPaginatedAdGrpc(adPage: Page<Ad>, page: Long, total: Long, pageCount: Long): AdOuterClass.PaginatedAd {
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

}