package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "users")
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    val username: String,
    val password: String,
    val email: String,
    val phone: String,
    val address: String,
    val avatar: String,


    @OneToMany(
        mappedBy = "user",
        fetch = FetchType.EAGER,
        orphanRemoval = true,
        cascade = [CascadeType.ALL]
    )
    val my_ads: MutableList<Ad> = mutableListOf(),


    @ElementCollection
    val fav_ads: MutableList<Ad> = mutableListOf(),

    @OneToMany(
        mappedBy = "performer",
        fetch = FetchType.EAGER,
        orphanRemoval = true,
        cascade = [CascadeType.ALL]
    )
    val taken_prompt: MutableList<Prompt> = mutableListOf(),

    @OneToMany(
        mappedBy = "owner",
        fetch = FetchType.EAGER,
        orphanRemoval = true,
        cascade = [CascadeType.ALL]
    )
    val my_prompt: MutableList<Prompt> = mutableListOf(),
) {
    fun addMyAd(block: User.() -> Ad) {
        my_ads.add(block())
    }
    fun deleteMyAd(block: User.() -> Ad) {
        my_ads.remove(block())
    }

    fun addFavAd(block: User.() -> Ad) {
        fav_ads.add(block())
    }

    fun deleteFavAd(block: User.() -> Ad) {
        fav_ads.remove(block())
    }
}