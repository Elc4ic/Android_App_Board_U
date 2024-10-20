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

fun Ad.toAdGrpc(isFav: Boolean = false): AdOuterClass.Ad {
    return AdOuterClass.Ad.newBuilder()
        .setId(this.id)
        .setTitle(this.title)
        .setPrice(this.price)
        .setDescription(this.description)
        .setIsFav(isFav)
        .setIsActive(this.isActive)
        .setViews(this.views)
        .setCreated(this.created)
        .setUser(this.user.toUserGrpc())
        .setCategory(this.category.toCategoryGrpc())
        .build()
}

fun List<Ad>.toRepeatedAdGrpc(): AdOuterClass.RepeatedAdResponse {
    val ads = mutableListOf<AdOuterClass.Ad>()
    this.forEach { ad -> ads.add(ad.toAdGrpc()) }
    return AdOuterClass.RepeatedAdResponse.newBuilder()
        .addAllData(ads)
        .build()
}

fun List<Favorites>.toFavRepeatedAdGrpc(): AdOuterClass.RepeatedAdResponse {
    val ads = mutableListOf<AdOuterClass.Ad>()
    this.forEach { fav -> ads.add(fav.ad.toAdGrpc()) }
    return AdOuterClass.RepeatedAdResponse.newBuilder()
        .addAllData(ads)
        .build()
}