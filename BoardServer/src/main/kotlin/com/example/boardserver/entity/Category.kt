package com.example.boardserver.entity

import board.AdOuterClass
import jakarta.persistence.*

@Entity
@Table(name = "category")
class Category(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    val name: String,
    val path: String,
)

fun Category.toCategoryGrpc(): AdOuterClass.Category {
    return AdOuterClass.Category.newBuilder()
        .setId(this.id)
        .setName(this.name)
        .setPath(this.path)
        .build()
}

fun AdOuterClass.Category.fromCategoryGrpc(): Category {
    return Category(
        id = this.id,
        name = this.name,
        path = this.path
    )
}

fun List<Category>.toCategoriesResponse(): AdOuterClass.GetAllCategoriesResponse {
    val cat = mutableListOf<AdOuterClass.Category>()
    this.forEach { c -> cat.add(c.toCategoryGrpc()) }
    return AdOuterClass.GetAllCategoriesResponse.newBuilder().addAllCategories(cat).build()
}