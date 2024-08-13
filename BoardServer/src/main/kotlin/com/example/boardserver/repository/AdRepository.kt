package com.example.boardserver.repository

import com.example.boardserver.entity.Ad
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.domain.Specification
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.JpaSpecificationExecutor
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface AdRepository : JpaSpecificationExecutor<Ad>,JpaRepository<Ad, Long> {
    override fun findById(id: Long): Optional<Ad>
    fun findByCategoryId(id: Long): MutableList<Ad>
    fun findByUserId(id: Long): MutableList<Ad>
}