package com.example.boardserver.delivery.grpc


import board.Chat
import board.Chat.RepeatedChatPreview
import board.Chat.SendMessageRequest
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.service.ChatService
import com.example.boardserver.utils.runWithTracing
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.transaction.annotation.Transactional


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class ChatServiceGrpc(
    private val chatService: ChatService,
    private val tracer: Tracer
) : board.ChatAPIGrpcKt.ChatAPICoroutineImplBase() {

    @Transactional
    override suspend fun startChat(request: Chat.StartRequest): Chat.StartResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, StartChat) {
                chatService.startChat(request)
            }
        }

    @Transactional
    override suspend fun deleteChat(request: Chat.DeleteChatRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteChat) {
                chatService.deleteChat(request)
            }
        }

    @Transactional
    override suspend fun getChatsPreview(request: UserOuterClass.Empty): RepeatedChatPreview =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetChatPreview) {
                chatService.getChatsPreview(request)
            }
        }

    @Transactional
    override suspend fun getAllMessage(request: Chat.GetAllMessagesRequest): Chat.GetAllMessagesResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetAllMessage) {
                chatService.getAllMessage(request)
            }
        }

    @Transactional
    override suspend fun deleteMessage(request: Chat.DeleteChatRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteMessage) {
                chatService.deleteMessage(request)
            }
        }


    override fun sendMessage(requests: Flow<SendMessageRequest>): Flow<Chat.Message> =
        runWithTracing(tracer, SendMessage) {
            chatService.sendMessage(requests)
        }


    companion object {
        private val log = LoggerFactory.getLogger(ChatServiceGrpc::class.java)
        private const val timeOutMillis = 5000L

        private const val chatService = "ChatAPI"
        private const val GetChatPreview = "$chatService.getChatService"
        private const val GetAllMessage = "$chatService.getAllMessage"
        private const val StartChat = "$chatService.startChat"
        private const val SendMessage = "$chatService.SendMessage"
        private const val DeleteChat = "$chatService.deleteChat"
        private const val DeleteMessage = "$chatService.deleteMessage"
    }
}