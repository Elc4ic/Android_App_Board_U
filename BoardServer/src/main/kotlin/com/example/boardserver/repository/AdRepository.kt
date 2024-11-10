package com.example.boardserver.repository

import com.example.boardserver.entity.Ad
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.JpaSpecificationExecutor
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*


@Repository
interface AdRepository : JpaSpecificationExecutor<Ad>, JpaRepository<Ad, UUID> {

    @Query("SELECT u FROM Ad u LEFT JOIN FETCH u.images WHERE u.id = ?1")
    fun findAdWithImages(userId: UUID): Optional<Ad>

    @Query("SELECT u FROM Ad u LEFT JOIN FETCH u.favorites WHERE u.id = ?1")
    fun findAdWithFavs(userId: UUID): Optional<Ad>

    fun findByTitle(title: String): Optional<Ad>

    @Query("SELECT CASE WHEN COUNT(u) > 0 THEN TRUE ELSE FALSE END FROM Ad u LEFT JOIN u.favorites f WHERE u.id = ?1 AND f.id = ?2")
    fun existsFavByUserIdAndAdId(adId: UUID?, userId: UUID?): Boolean

    override fun findById(id: UUID): Optional<Ad>
    fun findByUserId(id: UUID): MutableList<Ad>
    fun findByUserIdOrderByViewsDesc(id: UUID): MutableList<Ad>

}