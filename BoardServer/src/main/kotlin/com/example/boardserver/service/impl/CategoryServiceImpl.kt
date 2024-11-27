package com.example.boardserver.service.impl

import board.AdOuterClass
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.toCategoriesResponse
import com.example.boardserver.repository.CategoryRepository
import com.example.boardserver.service.CategoryService
import com.example.boardserver.utils.runWithTracing
import kotlinx.coroutines.withTimeout
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class CategoryServiceImpl(
    private val categoryRepository: CategoryRepository,
    private val tracer: Tracer,
) : CategoryService{

    override suspend fun getAllCategories(request: UserOuterClass.Empty): AdOuterClass.GetAllCategoriesResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetAllCategories) {
                val category = categoryRepository.findAll()
                category.toCategoriesResponse().also { log.info("categories: $it") }
            }
        }

    companion object {
        private val log = LoggerFactory.getLogger(CategoryServiceImpl::class.java)
        private const val timeOutMillis = 5000L

        private const val GetAllCategories = "CategoryAPI.getAllCategories"
    }
}