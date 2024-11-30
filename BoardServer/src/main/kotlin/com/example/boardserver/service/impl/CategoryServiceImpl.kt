package com.example.boardserver.service.impl

import brave.Tracer
import com.example.boardserver.entity.Category
import com.example.boardserver.repository.CategoryRepository
import com.example.boardserver.service.CategoryService
import com.example.boardserver.utils.runWithTracing
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class CategoryServiceImpl(
    private val categoryRepository: CategoryRepository,
    private val tracer: Tracer,
) : CategoryService {

    override suspend fun getAllCategories(): List<Category> =
        runWithTracing(tracer, GetAllCategories) {
            categoryRepository.findAll()
        }

    companion object {
        private val log = LoggerFactory.getLogger(CategoryServiceImpl::class.java)

        private const val GetAllCategories = "CategoryAPI.getAllCategories"
    }
}