package com.example.boardserver.utils

import board.AdOuterClass
import com.example.boardserver.entity.Ad
import com.example.boardserver.entity.Category
import com.example.boardserver.entity.User
import jakarta.persistence.criteria.CriteriaBuilder
import jakarta.persistence.criteria.CriteriaQuery
import jakarta.persistence.criteria.Predicate
import jakarta.persistence.criteria.Root
import org.springframework.data.jpa.domain.Specification


object FilterUtils {

    fun adSpecification(request: AdOuterClass.GetManyAdRequest): Specification<Ad> {
        return Specification<Ad> { root: Root<Ad?>, query: CriteriaQuery<*>, criteriaBuilder: CriteriaBuilder ->
            val andPredicates: MutableList<Predicate> = ArrayList()
            andPredicates.add(
                criteriaBuilder.like(
                    root.get<Ad>("user").get("address"),
                    "%${request.filter.address}%"
                )
            )
            if (request.filter.priceMin > 0) {
                andPredicates.add(criteriaBuilder.greaterThanOrEqualTo(root.get("price"), request.filter.priceMin))
            }
            if (request.filter.priceMax > 0) {
                andPredicates.add(criteriaBuilder.lessThanOrEqualTo(root.get("price"), request.filter.priceMax))
            }
            if (request.filter.category.name != "") {
                andPredicates.add(
                    (criteriaBuilder.equal(
                        root.get<Ad>("category").get<Category>("name"),
                        request.filter.category.name
                    ))
                )
            }
            andPredicates.add(criteriaBuilder.equal(root.get<Ad>("isActive"), true))
            val andPredicate: Predicate = criteriaBuilder.and(*andPredicates.toTypedArray())

            val orPredicates: MutableList<Predicate> = ArrayList()
            request.filter.search.let { orPredicates.add(criteriaBuilder.like(root.get("title"), "%$it%")) }
            request.filter.search.let { orPredicates.add(criteriaBuilder.like(root.get("description"), "%$it%")) }
            val orPredicate: Predicate = criteriaBuilder.or(*orPredicates.toTypedArray())
            when (request.filter.query) {
                "Старые" -> {query.orderBy(criteriaBuilder.asc(root.get<Ad>("created"))) }
                "Новые" -> {query.orderBy(criteriaBuilder.desc(root.get<Ad>("created")))}
                "Дорогие" -> {query.orderBy(criteriaBuilder.desc(root.get<Ad>("price")))}
                "Дешевые" -> {query.orderBy(criteriaBuilder.asc(root.get<Ad>("price")))}
                "По умолчанию" -> {}
                "Популярные" -> {query.orderBy(criteriaBuilder.desc(root.get<Ad>("views")))}
                else -> {}
            }
            criteriaBuilder.and(andPredicate, orPredicate)
        }
    }
}