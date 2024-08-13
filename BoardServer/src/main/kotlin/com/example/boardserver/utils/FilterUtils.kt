package com.example.boardserver.utils

import board.AdOuterClass
import com.example.boardserver.entity.Ad
import com.example.boardserver.entity.Category
import jakarta.persistence.criteria.CriteriaBuilder
import jakarta.persistence.criteria.CriteriaQuery
import jakarta.persistence.criteria.Predicate
import jakarta.persistence.criteria.Root
import org.springframework.data.jpa.domain.Specification


object FilterUtils {

    fun adSpecification(request: AdOuterClass.GetManyAdRequest): Specification<Ad> {
        return Specification<Ad> { root: Root<Ad?>, query: CriteriaQuery<*>, criteriaBuilder: CriteriaBuilder ->
            val andPredicates: MutableList<Predicate> = ArrayList()
            andPredicates.add(request.filter.address.let { criteriaBuilder.like(root.get<Ad>("user").get("address"), "%$it%") })
            andPredicates.add(criteriaBuilder.between(root.get("price"), request.filter.priceMin, request.filter.priceMax))
            andPredicates.add(criteriaBuilder.equal(root.get<Ad>("isActive"), true))
            andPredicates.add((request.filter.category.let { criteriaBuilder.equal(root.get<Ad>("category").get<Category>("name"),it.name) }))
            val andPredicate: Predicate = criteriaBuilder.and(*andPredicates.toTypedArray())
            val orPredicates: MutableList<Predicate> = ArrayList()
            orPredicates.add(request.filter.search.let { criteriaBuilder.like(root.get("title"), "%$it%") })
            orPredicates.add(request.filter.search.let { criteriaBuilder.like(root.get("description"), "%$it%") })
            val orPredicate: Predicate = criteriaBuilder.or(*orPredicates.toTypedArray())
            /*query.orderBy(criteriaBuilder.asc(root.get<Ad>("date")))*/
            criteriaBuilder.and(andPredicate, orPredicate)
        }
    }

    /* fun specTitle(request: AdOuterClass.GetManyAdRequest): Specification<Ad> {
         return Specification { root, _, criteriaBuilder ->
             request.filter.search.let { criteriaBuilder.like(root.get("title"), "%$it%") }
         }
     }*/
}