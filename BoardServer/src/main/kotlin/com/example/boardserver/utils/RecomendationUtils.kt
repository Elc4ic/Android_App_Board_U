package com.example.boardserver.utils

import com.example.boardserver.entity.Ad
import com.example.boardserver.entity.Category
import com.example.boardserver.entity.Favorites
import jakarta.persistence.criteria.CriteriaBuilder
import jakarta.persistence.criteria.Predicate
import jakarta.persistence.criteria.Root


object RecommendationUtils {

    fun calculateSimilarity(cb: CriteriaBuilder, ad: Root<Ad?>, ads: List<Favorites>): Double {
        var similarityScore = 0.0

        for (fav in ads) {
            similarityScore += calculateTitleSimilarity(cb, ad, fav.ad.title) * 3
            similarityScore += calculateDescSimilarity(cb, ad, fav.ad.description) * 2
            similarityScore += calculatePriceSimilarity(cb, ad, fav.ad.price)
            similarityScore += calculateCategorySimilarity(cb, ad, fav.ad.category)
        }
        return similarityScore
    }

    private fun calculateTitleSimilarity(cb: CriteriaBuilder, root: Root<Ad?>, title: String): Double {
        var count = 0
        var predicate: Predicate
        val words2: Set<String> = title.split(" ").toSet()
        words2.forEach {
            predicate = cb.like(root.get("title"), "%${it.substring(0, (it.length * 0.7).toInt())}%")
            if (!predicate.isNegated) {
                count++
            }
        }
        return count.toDouble() / words2.size
    }

    private fun calculateDescSimilarity(cb: CriteriaBuilder, root: Root<Ad?>, desc: String?): Double {
        var count = 0
        var predicate: Predicate
        val words2: Set<String> = desc?.split(" ")?.toSet() ?: setOf()
        words2.forEach {
            predicate = cb.like(root.get("description"), "%${it.substring(0, (it.length * 0.7).toInt())}%")
            if (!predicate.isNegated) {
                count++
            }
        }
        return count.toDouble() / words2.size
    }

    private fun calculatePriceSimilarity(cb: CriteriaBuilder, root: Root<Ad?>, price2: Long): Double {
        var count = 0.0
        if (cb.greaterThanOrEqualTo(root.get("price"), price2 * 1.3).isNegated) count += 0.5
        if (cb.lessThanOrEqualTo(root.get("price"), price2 * 0.70).isNegated) count += 0.5
        return count
    }

    private fun calculateCategorySimilarity(cb: CriteriaBuilder, root: Root<Ad?>, category2: Category): Double {
        return if (!cb.equal(root.get<Ad>("category").get<Category>("name"), category2.name).isNegated) 1.0 else 0.0
    }

}