package com.example.boardserver.service

import board.AdOuterClass
import board.PromptOuterClass
import com.example.boardserver.repository.AdRepository
import com.example.boardserver.repository.CategoryRepository
import com.example.boardserver.repository.UserRepository
import io.grpc.stub.StreamObserver

class PromptService(
    private val adRepository: AdRepository,
    private val categoryRepository: CategoryRepository,
    private val userRepository: UserRepository
) : board.PromptAPIGrpc.PromptAPIImplBase() {

    override fun getManyPrompts(
        request: PromptOuterClass.GetManyPromptsRequest?,
        responseObserver: StreamObserver<PromptOuterClass.PaginatedPrompt>?
    ) {
        super.getManyPrompts(request, responseObserver)
    }

    override fun getOnePrompt(
        request: AdOuterClass.GetByIdRequest?,
        responseObserver: StreamObserver<PromptOuterClass.Prompt>?
    ) {
        super.getOnePrompt(request, responseObserver)
    }

    override fun setFavoritePrompt(
        request: AdOuterClass.SetFavoriteRequest?,
        responseObserver: StreamObserver<AdOuterClass.Empty>?
    ) {
        super.setFavoritePrompt(request, responseObserver)
    }

    override fun addPrompt(
        request: PromptOuterClass.ChangePromptRequest?,
        responseObserver: StreamObserver<AdOuterClass.Empty>?
    ) {
        super.addPrompt(request, responseObserver)
    }

    override fun deletePrompt(
        request: PromptOuterClass.ChangePromptRequest?,
        responseObserver: StreamObserver<AdOuterClass.Empty>?
    ) {
        super.deletePrompt(request, responseObserver)
    }

    override fun mutePrompt(
        request: PromptOuterClass.ChangePromptRequest?,
        responseObserver: StreamObserver<AdOuterClass.Empty>?
    ) {
        super.mutePrompt(request, responseObserver)
    }

    override fun getPerform(
        request: PromptOuterClass.SetPerformRequest?,
        responseObserver: StreamObserver<AdOuterClass.Empty>?
    ) {
        super.getPerform(request, responseObserver)
    }
}