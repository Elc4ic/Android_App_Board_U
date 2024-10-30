package com.example.boardserver.repository

import com.example.boardserver.entity.Image
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface ImageRepository : JpaRepository<Image, Long> {
    fun deleteAllByAdId(id: Long)
    fun findByAdId(id: Long): MutableList<Image>
    fun findFirstByAdId(id: Long): Optional<Image>

    @Query("SELECT e.id FROM Image e WHERE e.ad.id = ?1")
    fun findAllIdsByAdId(id: Long): MutableList<Long>
}