package com.example.boardserver.repository

import com.example.boardserver.entity.Favorites
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface FavoritesRepository : JpaRepository<Favorites, Long> {
    fun findByUserId(id: Long): MutableList<Favorites>
    fun findByAdIdAndUserId(adId: Long, userId: Long): Optional<Favorites>
    fun countByUserIdAndAdId(userId: Long, adId: Long): Long
}