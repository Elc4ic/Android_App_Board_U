package com.example.boardserver.entity

import board.AdOuterClass
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table
import java.util.*

@Entity
@Table(name = "category")
class Category(
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
        name = this.name,
        path = this.path
    )
}

fun List<Category>.toCategoriesResponse(): AdOuterClass.GetAllCategoriesResponse {
    val cat = mutableListOf<AdOuterClass.Category>()
    this.forEach { c -> cat.add(c.toCategoryGrpc()) }
    return AdOuterClass.GetAllCategoriesResponse.newBuilder().addAllCategories(cat).build()
}