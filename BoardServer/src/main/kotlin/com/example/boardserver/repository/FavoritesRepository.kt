package com.example.boardserver.repository

import com.example.boardserver.entity.Favorites
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface FavoritesRepository : JpaRepository<Favorites, UUID> {
    fun deleteAllByAdId(id: UUID)
    fun deleteAllByUserId(id: UUID)
    fun findByUserId(id: UUID): MutableList<Favorites>
    fun findByAdIdAndUserId(adId: UUID, userId: UUID): Optional<Favorites>
    fun existsByUserIdAndAdId(userId: UUID, adId: UUID): Boolean
}