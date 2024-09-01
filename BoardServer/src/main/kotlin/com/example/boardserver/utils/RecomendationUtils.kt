package com.example.boardserver.utils

import com.example.boardserver.entity.Ad
import com.example.boardserver.entity.Category
import kotlin.math.abs
import kotlin.math.max


object RecommendationUtils {

    fun calculateSimilarity(ad1: Ad, ads: List<Ad>): Double {
        var similarityScore = 0.0

        for ( ad2 in ads){
            similarityScore += calculateTitleSimilarity(ad1.title, ad2.title) * 3
            similarityScore += calculatePriceSimilarity(ad1.price, ad2.price)
            similarityScore += calculateCategorySimilarity(ad1.category, ad2.category)
        }
        return similarityScore
    }

    private fun calculateTitleSimilarity(title1: String, title2: String): Double {
        val words1: Set<String> = title1.split(" ").toSet()
        val words2: Set<String> = title2.split(" ").toSet()
        val intersection: MutableSet<String> = HashSet(words1)
        intersection.retainAll(words2)
        return intersection.size.toDouble() / (words1.size + words2.size - intersection.size)
    }

    private fun calculatePriceSimilarity(price1: Long, price2: Long): Double {
        return 1.0 - abs(price1 - price2) / max(price1, price2)
    }

    private fun calculateCategorySimilarity(category1: Category, category2: Category): Double {
        return if (category1.id == category2.id) 1.0 else 0.0
    }

}