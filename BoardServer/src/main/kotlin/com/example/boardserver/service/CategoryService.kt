package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import org.springframework.stereotype.Service

@Service
interface CategoryService {
    suspend fun getAllCategories(request: UserOuterClass.Empty): AdOuterClass.GetAllCategoriesResponse
}