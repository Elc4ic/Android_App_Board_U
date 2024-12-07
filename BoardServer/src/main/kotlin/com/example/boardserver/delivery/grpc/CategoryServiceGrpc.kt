package com.example.boardserver.delivery.grpc

import board.AdOuterClass
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.toCategoriesResponse
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.service.CategoryService
import com.example.boardserver.utils.runWithTracing
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory

@GrpcService(interceptors = [LogGrpcInterceptor::class])
class CategoryServiceGrpc(
    private val categoryService: CategoryService,
    private val tracer: Tracer,
) : board.CategoryAPIGrpcKt.CategoryAPICoroutineImplBase() {

    override suspend fun getAllCategories(request: UserOuterClass.Empty): AdOuterClass.GetAllCategoriesResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan( GetAllCategories)
            runWithTracing(span) {
                categoryService.getAllCategories().toCategoriesResponse().also { span.tag("response", it.toString()) }
            }
        }


    companion object {
        private val log = LoggerFactory.getLogger(CategoryServiceGrpc::class.java)
        private const val timeOutMillis = 5000L

        private const val GetAllCategories = "CategoryAPI.getAllCategories"
    }
}