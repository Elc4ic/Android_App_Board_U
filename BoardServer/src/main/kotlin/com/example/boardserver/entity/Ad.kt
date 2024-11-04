package com.example.boardserver.entity

import board.AdOuterClass
import jakarta.persistence.*
import org.springframework.data.domain.Page
import java.time.LocalDateTime
import java.util.*

@Entity
@Table(name = "ads")
class Ad(
    @Id val id: UUID,
    var title: String = "",
    var price: Long = 0,
    var description: String = "",
    var isActive: Boolean = false,
    var views: Int = 0,
    var created: LocalDateTime? = null,

    @ManyToOne
    @JoinColumn(name = "users_id")
    var user: User,

    @ManyToOne
    @JoinColumn(name = "category_id")
    var category: Category,

    @OneToMany(mappedBy = "ad", cascade = [CascadeType.ALL], orphanRemoval = true)
    private var _images: MutableSet<Image> = mutableSetOf()
){
    val images get() = _images.toList()

    fun addImage(image: Image) {
        _images.add(image)
        image.ad = this
    }
}


fun AdOuterClass.Ad.fromAdGrpc(): Ad {
    return Ad(
        id = UUID.randomUUID(),
        title = this.title,
        price = this.price,
        description = this.description,
        isActive = this.isActive,
        views = this.views,
        created = LocalDateTime.now(),
        user = this.user.fromUserGrpc(),
        category = this.category.fromCategoryGrpc(),
    )
}

fun Ad.toAdGrpc(isFav: Boolean = false): AdOuterClass.Ad {
    return AdOuterClass.Ad.newBuilder()
        .setId(this.id.toString())
        .setTitle(this.title)
        .setPrice(this.price)
        .setDescription(this.description)
        .setIsFav(isFav)
        .setIsActive(this.isActive)
        .setViews(this.views)
        .setCreated(this.created.toString())
        .setUser(this.user.toUserMini())
        .setCategory(this.category.toCategoryGrpc())
        .addAllImages(this.images.map { it.id.toString() })
        .build()
}

fun Ad.toMyAd(): AdOuterClass.Ad {
    return AdOuterClass.Ad.newBuilder()
        .setId(this.id.toString())
        .setTitle(this.title)
        .setPrice(this.price)
        .setIsActive(this.isActive)
        .setViews(this.views)
        .setCreated(this.created.toString())
        .build()
}

fun Ad.toAdPreview(isFav: Boolean = false): AdOuterClass.Ad {
    return AdOuterClass.Ad.newBuilder()
        .setId(this.id.toString())
        .setTitle(this.title)
        .setPrice(this.price)
        .setIsFav(isFav)
        .setUser(this.user.toUserPreview())
        .setCreated(this.created.toString())
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

fun Page<Ad>.toPagedAdPreview(
    favs: List<Favorites>,
): AdOuterClass.PaginatedAd {
    val ads = mutableListOf<AdOuterClass.Ad>()

    this.forEach { ad ->
        ads.add(
            ad.toAdPreview(
                favs.find { it.ad.id == ad.id } != null
            )
        )
    }
    return AdOuterClass.PaginatedAd.newBuilder()
        .addAllData(ads).build()
}