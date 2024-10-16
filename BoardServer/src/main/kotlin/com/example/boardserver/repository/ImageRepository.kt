package com.example.boardserver.repository

import com.example.boardserver.entity.Image
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface ImageRepository : JpaRepository<Image, Long> {
    fun deleteAllByAdId(id: Long)
    fun findByAdId(id: Long): MutableList<Image>
    fun findFirstByAdId(id: Long): Optional<Image>
}