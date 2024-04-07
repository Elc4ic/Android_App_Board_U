package com.example.boardserver.repository

import com.example.boardserver.entity.Ad
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface AdRepository : JpaRepository<Ad, String> {
    override fun findById(id: String): Optional<Ad>
}