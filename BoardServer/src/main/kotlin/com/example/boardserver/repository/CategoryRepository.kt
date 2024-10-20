package com.example.boardserver.repository

import com.example.boardserver.entity.Category
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface CategoryRepository : JpaRepository<Category, Long> {
    override fun findById(id: Long): Optional<Category>
}