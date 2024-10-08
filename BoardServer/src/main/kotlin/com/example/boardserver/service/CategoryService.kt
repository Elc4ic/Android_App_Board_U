package com.example.boardserver.service

import board.AdOuterClass
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.CategoryRepository
import com.example.boardserver.utils.AdUtils
import com.example.boardserver.utils.CategoryUtils
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService

@GrpcService
class CategoryService(
    private val categoryRepository: CategoryRepository,
) : board.CategoryAPIGrpc.CategoryAPIImplBase() {

    override fun getAllCategories(
        request: AdOuterClass.Empty?,
        responseObserver: StreamObserver<AdOuterClass.GetAllCategoriesResponse>?
    ) {
        val category = categoryRepository.findAll()
        responseObserver?.onNext(CategoryUtils.toCategoriesResponse(category))
        responseObserver?.onCompleted()
    }

}