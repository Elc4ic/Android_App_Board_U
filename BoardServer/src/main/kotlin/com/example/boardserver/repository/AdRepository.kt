package com.example.boardserver.repository

import com.example.boardserver.entity.Ad
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.JpaSpecificationExecutor
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface AdRepository : JpaSpecificationExecutor<Ad>,JpaRepository<Ad, UUID> {
    override fun findById(id: UUID): Optional<Ad>
    fun findByUserId(id: UUID): MutableList<Ad>
    fun findByUserIdOrderByViewsDesc(id: UUID): MutableList<Ad>
}