package com.example.boardserver.entity

import board.AdOuterClass
import jakarta.persistence.*
import org.springframework.data.domain.Page
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.*

@Entity
@Table(name = "ads")
class Ad(
    @GeneratedValue(strategy = GenerationType.UUID)
    @Id val id: UUID? = null,
    var title: String = "",
    var price: Long = 0,
    var description: String = "",
    var isActive: Boolean = true,
    var views: Int = 0,
    var created: LocalDateTime? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "users_id")
    var user: User? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    var category: Category? = null,

    @OneToMany(mappedBy = "ad", fetch = FetchType.LAZY, cascade = [CascadeType.ALL], orphanRemoval = true)
    var images: MutableSet<Image> = mutableSetOf(),

    @ManyToMany(
        mappedBy = "favs",
        cascade = [
            CascadeType.DETACH,
            CascadeType.MERGE,
            CascadeType.PERSIST,
            CascadeType.REFRESH
        ],
    )
    var favorites: MutableSet<User> = mutableSetOf()
) {
    fun updateImage(image: Image) {
        images += image
        image.ad = this
    }
}


fun AdOuterClass.Ad.fromAdGrpc(new: Boolean = false): Ad {
    val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
    return Ad(
        id = if (new) null else UUID.fromString(this.id),
        title = this.title,
        price = this.price,
        description = this.description,
        isActive = this.isActive,
        views = this.views,
        created = if (new) LocalDateTime.now() else LocalDateTime.parse(this.created),
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
        .setUser(this.user?.toUserMini())
        .setCategory(this.category?.toCategoryGrpc())
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
        .setUser(this.user?.toUserPreview())
        .setCreated(this.created.toString())
        .build()
}

fun List<Ad>.toRepeatedAdGrpc(fav: Boolean = false): AdOuterClass.RepeatedAdResponse {
    return AdOuterClass.RepeatedAdResponse.newBuilder()
        .addAllData(this.map { it.toAdPreview(fav) })
        .build()
}

fun List<Ad>.toRepeatedMyAd(): AdOuterClass.RepeatedAdResponse {
    return AdOuterClass.RepeatedAdResponse.newBuilder()
        .addAllData(this.map { it.toMyAd() })
        .build()
}

fun Page<Ad>.toPagedAdPreview(favs: List<Ad>): AdOuterClass.PaginatedAd {
    val ads = this.map {
        it.toAdPreview(favs.find { fav -> fav.id == it.id } != null)
    }.toList()

    return AdOuterClass.PaginatedAd.newBuilder()
        .addAllData(ads).build()
}