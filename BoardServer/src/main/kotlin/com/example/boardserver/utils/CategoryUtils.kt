package com.example.boardserver.utils

import board.AdOuterClass
import com.example.boardserver.entity.Category

object CategoryUtils {
    fun toCategoryGrpc(cat: Category): AdOuterClass.Category {
        return AdOuterClass.Category.newBuilder()
            .setId(cat.id)
            .setName(cat.name)
            .setPath(cat.path)
            .build()
    }

    fun fromCategoryGrpc(category: AdOuterClass.Category): Category {
        return Category(
            id = category.id,
            name = category.name,
            path = category.path
        )
    }

    fun toCategoriesResponse(category: List<Category>): AdOuterClass.GetAllCategoriesResponse {
        val cat = mutableListOf<AdOuterClass.Category>()
        category.forEach { c -> cat.add(toCategoryGrpc(c)) }
        return AdOuterClass.GetAllCategoriesResponse.newBuilder().addAllCategories(cat).build()
    }
}