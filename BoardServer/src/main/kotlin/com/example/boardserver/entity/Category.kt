package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "category")
class Category(
    @Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
    val id: Long,
    val name: String,
    @OneToMany(
        mappedBy = "category",
        fetch = FetchType.LAZY,
        orphanRemoval = true,
        cascade = [CascadeType.ALL]
    )
    val ads: MutableList<Ad> = mutableListOf()
){
    fun addAds(block: Category.() -> Ad) {
        ads.add(block())
    }

    fun setAds(block: Category.() -> MutableSet<Ad>) {
        ads.clear()
        ads.addAll(block())
    }
}