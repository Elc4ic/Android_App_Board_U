package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.toCategoriesResponse
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.CategoryRepository
import com.example.boardserver.utils.runWithTracing
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory

@GrpcService(interceptors = [LogGrpcInterceptor::class])
class CategoryService(
    private val categoryRepository: CategoryRepository,
    private val tracer: Tracer,
) : board.CategoryAPIGrpcKt.CategoryAPICoroutineImplBase() {

    override suspend fun getAllCategories(request: UserOuterClass.Empty): AdOuterClass.GetAllCategoriesResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetAllCategories) {
                val category = categoryRepository.findAll()
                category.toCategoriesResponse()
            }
        }


    companion object {
        private val log = LoggerFactory.getLogger(CategoryService::class.java)
        private const val timeOutMillis = 5000L

        private const val GetAllCategories = "CategoryAPI.getAllCategories"
    }
}