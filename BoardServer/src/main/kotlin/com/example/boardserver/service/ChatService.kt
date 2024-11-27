package com.example.boardserver.service

import board.Chat
import board.Chat.RepeatedChatPreview
import board.Chat.SendMessageRequest
import board.UserOuterClass
import kotlinx.coroutines.flow.Flow
import org.springframework.stereotype.Service


@Service
interface ChatService {
    suspend fun startChat(request: Chat.StartRequest): Chat.StartResponse
    suspend fun deleteChat(request: Chat.DeleteChatRequest): UserOuterClass.IsSuccess
    suspend fun getChatsPreview(request: UserOuterClass.Empty): RepeatedChatPreview
    suspend fun getAllMessage(request: Chat.GetAllMessagesRequest): Chat.GetAllMessagesResponse
    suspend fun deleteMessage(request: Chat.DeleteChatRequest): UserOuterClass.IsSuccess
    fun sendMessage(requests: Flow<SendMessageRequest>): Flow<Chat.Message>
}