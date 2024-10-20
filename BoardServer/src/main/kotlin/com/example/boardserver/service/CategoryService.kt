package com.example.boardserver.service

import board.AdOuterClass
import com.example.boardserver.entity.toCategoriesResponse
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.CategoryRepository
import com.example.boardserver.utils.runWithTracing
import io.micrometer.tracing.Tracer
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory

@GrpcService(interceptors = [LogGrpcInterceptor::class])
class CategoryService(
    private val categoryRepository: CategoryRepository,
    private val tracer: Tracer,
) : board.CategoryAPIGrpcKt.CategoryAPICoroutineImplBase() {

    override suspend fun getAllCategories(request: AdOuterClass.Empty): AdOuterClass.GetAllCategoriesResponse =
            withTimeout(timeOutMillis) {
                val span = tracer.startScopedSpan(GetAllCategories)
                val category = categoryRepository.findAll()
                val response = category.toCategoriesResponse()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("get all categories: $it").also { span.tag("image", it.toString()) }
                    }
                }
            }


    companion object {
        private val log = LoggerFactory.getLogger(CategoryService::class.java)
        private const val timeOutMillis = 5000L

        private const val GetAllCategories = "GetAllCategories"
    }
}