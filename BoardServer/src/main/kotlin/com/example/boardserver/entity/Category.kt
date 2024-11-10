package com.example.boardserver.entity

import board.AdOuterClass
import jakarta.persistence.*
import java.util.*

@Entity
@Table(name = "category")
class Category(
    @GeneratedValue(strategy = GenerationType.UUID)
    @Id val id: UUID? = null,
    val name: String = "",
    val path: String = "",
)

fun Category.toCategoryGrpc(): AdOuterClass.Category {
    return AdOuterClass.Category.newBuilder()
        .setId(this.id.toString())
        .setName(this.name)
        .setPath(this.path)
        .build()
}

fun AdOuterClass.Category.fromCategoryGrpc(): Category {
    return Category(
        id = UUID.fromString(this.id),
        name = this.name,
        path = this.path
    )
}

fun List<Category>.toCategoriesResponse(): AdOuterClass.GetAllCategoriesResponse {
    val cat = this.map { it.toCategoryGrpc() }
    return AdOuterClass.GetAllCategoriesResponse.newBuilder().addAllCategories(cat).build()
}