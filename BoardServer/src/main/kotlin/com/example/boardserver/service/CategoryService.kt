package com.example.boardserver.service

import com.example.boardserver.entity.Category
import org.springframework.stereotype.Service

@Service
interface CategoryService {
    suspend fun getAllCategories(): List<Category>
}