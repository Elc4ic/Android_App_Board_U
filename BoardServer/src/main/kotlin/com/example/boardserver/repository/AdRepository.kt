package com.example.boardserver.repository

import com.example.boardserver.entity.Ad
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.JpaSpecificationExecutor
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface AdRepository : JpaSpecificationExecutor<Ad>,JpaRepository<Ad, Long> {
    override fun findById(id: Long): Optional<Ad>
    fun findByUserId(id: Long): MutableList<Ad>
}