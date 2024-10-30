package com.example.boardserver.entity

import board.AdOuterClass
import jakarta.persistence.*

@Entity
@Table(name = "ads")
class Ad(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    var title: String,
    var price: Long,
    var description: String? = null,
    var isActive: Boolean = true,
    var views: Int = 0,
    var created: String,

    @ManyToOne
    @JoinColumn(name = "users_id")
    val user: User,

    @ManyToOne
    @JoinColumn(name = "category_id")
    val category: Category
)

fun AdOuterClass.Ad.fromAdGrpc(): Ad {
    return Ad(
        id = this.id,
        title = this.title,
        price = this.price,
        description = this.description,
        isActive = this.isActive,
        views = this.views,
        created = this.created,
        user = this.user.fromUserGrpc(),
        category = this.category.fromCategoryGrpc(),
    )
}

fun Ad.toAdGrpc(isFav: Boolean = false, images: List<Long> = emptyList()): AdOuterClass.Ad {
    return AdOuterClass.Ad.newBuilder()
        .setId(this.id)
        .setTitle(this.title)
        .setPrice(this.price)
        .setDescription(this.description)
        .setIsFav(isFav)
        .setIsActive(this.isActive)
        .setViews(this.views)
        .setCreated(this.created)
        .setUser(this.user.toUserMini())
        .setCategory(this.category.toCategoryGrpc())
        .addAllImages(images)
        .build()
}

fun Ad.toMyAd(): AdOuterClass.Ad {
    return AdOuterClass.Ad.newBuilder()
        .setId(this.id)
        .setTitle(this.title)
        .setPrice(this.price)
        .setIsActive(this.isActive)
        .setViews(this.views)
        .setCreated(this.created)
        .build()
}

fun Ad.toAdPreview(isFav: Boolean = false): AdOuterClass.Ad {
    return AdOuterClass.Ad.newBuilder()
        .setId(this.id)
        .setTitle(this.title)
        .setPrice(this.price)
        .setIsFav(isFav)
        .setUser(this.user.toUserPreview())
        .build()
}

fun List<Ad>.toRepeatedAdGrpc(): AdOuterClass.RepeatedAdResponse {
    val ads = mutableListOf<AdOuterClass.Ad>()
    this.forEach { ad -> ads.add(ad.toAdPreview()) }
    return AdOuterClass.RepeatedAdResponse.newBuilder()
        .addAllData(ads)
        .build()
}

fun List<Ad>.toRepeatedMyAd(): AdOuterClass.RepeatedAdResponse {
    val ads = mutableListOf<AdOuterClass.Ad>()
    this.forEach { ad -> ads.add(ad.toMyAd()) }
    return AdOuterClass.RepeatedAdResponse.newBuilder()
        .addAllData(ads)
        .build()
}

fun List<Favorites>.toFavRepeatedAdPreviews(): AdOuterClass.RepeatedAdResponse {
    val ads = mutableListOf<AdOuterClass.Ad>()
    this.forEach { fav -> ads.add(fav.ad.toAdPreview(true)) }
    return AdOuterClass.RepeatedAdResponse.newBuilder()
        .addAllData(ads)
        .build()
}