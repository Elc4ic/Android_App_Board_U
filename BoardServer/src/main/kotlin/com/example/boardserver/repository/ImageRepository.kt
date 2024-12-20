package com.example.boardserver.repository

import com.example.boardserver.entity.Image
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
interface ImageRepository : JpaRepository<Image, UUID> {

    @Modifying
    @Transactional
    fun deleteAllByAdId(id: UUID)

    fun findFirstByAdId(id: UUID): Optional<Image>

    @Query("SELECT e.id FROM Image e WHERE e.ad.id = ?1")
    fun findAllIdsByAdId(id: UUID): MutableList<UUID>
}