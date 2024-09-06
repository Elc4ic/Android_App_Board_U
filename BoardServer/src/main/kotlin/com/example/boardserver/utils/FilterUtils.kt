package com.example.boardserver.utils

import board.AdOuterClass
import com.example.boardserver.entity.Ad
import com.example.boardserver.entity.Category
import com.example.boardserver.entity.Favorites
import jakarta.persistence.criteria.CriteriaBuilder
import jakarta.persistence.criteria.CriteriaQuery
import jakarta.persistence.criteria.Predicate
import jakarta.persistence.criteria.Root
import org.springframework.data.jpa.domain.Specification


object FilterUtils {

    fun adSpecification(request: AdOuterClass.GetManyAdRequest, favList: List<Favorites>): Specification<Ad> {
        return Specification<Ad> { root: Root<Ad?>, query: CriteriaQuery<*>, cb: CriteriaBuilder ->
            val andPredicates: MutableList<Predicate> = ArrayList()
            andPredicates.add(
                cb.like(
                    root.get<Ad>("user").get("address"),
                    "%${request.filter.address}%"
                )
            )
            if (request.filter.priceMin > 0) {
                andPredicates.add(cb.greaterThanOrEqualTo(root.get("price"), request.filter.priceMin))
            }
            if (request.filter.priceMax > 0) {
                andPredicates.add(cb.lessThanOrEqualTo(root.get("price"), request.filter.priceMax))
            }
            if (request.filter.category.name != "") {
                andPredicates.add(
                    (cb.equal(
                        root.get<Ad>("category").get<Category>("name"),
                        request.filter.category.name
                    ))
                )
            }
            andPredicates.add(cb.equal(root.get<Ad>("isActive"), true))
            val andPredicate: Predicate = cb.and(*andPredicates.toTypedArray())

            val orPredicates: MutableList<Predicate> = ArrayList()
            request.filter.search.let { orPredicates.add(cb.like(root.get("title"), "%$it%")) }
            request.filter.search.let { orPredicates.add(cb.like(root.get("description"), "%$it%")) }
            val orPredicate: Predicate = cb.or(*orPredicates.toTypedArray())
            when (request.filter.query) {
                "Старые" -> {
                    query.orderBy(cb.asc(root.get<Ad>("created")))
                }

                "Новые" -> {
                    query.orderBy(cb.desc(root.get<Ad>("created")))
                }

                "Дорогие" -> {
                    query.orderBy(cb.desc(root.get<Ad>("price")))
                }

                "Дешевые" -> {
                    query.orderBy(cb.asc(root.get<Ad>("price")))
                }

                "По умолчанию" -> {

                    query.orderBy(
                        cb.desc(
                            cb.literal(RecommendationUtils.calculateSimilarity(cb,root, favList))
                                .`as`(Double::class.java),
                            /*cb.function(
                                "calculate_similarity",
                                Double::class.java,
                                root.get<Ad>("title"),
                                root.get<Ad>("price"),
                                root.get<Ad>("category").get<Category>("id"),
                                cb.literal(userId).`as`(Long::class.java)
                            )*/
                        )
                    )
                }

                "Популярные" -> {
                    query.orderBy(cb.desc(root.get<Ad>("views")))
                }

                else -> {}
            }
            cb.and(andPredicate, orPredicate)
        }
    }
}