package com.example.boardserver.service

import board.Chat
import board.Chat.RepeatedChatPreview
import board.Chat.SendMessageRequest
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.*
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.*
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.runWithTracing
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.FirebaseMessagingException
import com.google.firebase.messaging.Message
import com.google.firebase.messaging.Notification
import io.grpc.Context
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.data.domain.Sort
import org.springframework.transaction.annotation.Transactional


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class ChatService(
    private val chatRepository: ChatRepository,
    private val messageRepository: MessageRepository,
    private val userRepository: UserRepository,
    private val tokenRepository: TokenRepository,
    private val fmcProvider: FcmProvider,
    private val firebaseMessaging: FirebaseMessaging,
    private val tracer: Tracer
) : board.ChatAPIGrpcKt.ChatAPICoroutineImplBase() {

    override suspend fun startChat(request: Chat.StartRequest): Chat.StartResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(StartChat)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val ownerId = request.ad.user.id.uuid()
                val adId = request.ad.id.uuid()
                val user = userRepository.findById(userId).get()
                val chat = chatRepository.findChatBetweenUsersByIds(ownerId, userId, adId)
                    .orElse(request.ad.createChat(request.ad.user, user))
                    .also { chatRepository.save(it) }
                chat.toStartResponse().also { it ->
                    log.info("start chat: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun deleteChat(request: Chat.DeleteChatRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteChat)
            runWithTracing(span) {
                chatRepository.deleteById(request.chatId.uuid())
                successGrpc().also { it ->
                    log.info("delete chat: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getChatsPreview(request: UserOuterClass.Empty): RepeatedChatPreview =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetChatPreview)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val chats = chatRepository.findByOwnerId(userId, Sort.by(Sort.Direction.DESC, "lastMessage.data"))
                val response = RepeatedChatPreview.newBuilder()
                    .addAllChats(chats.toRepeatedChat(userId))
                    .build()
                response.also { it ->
                    log.info("get chats: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    override suspend fun getAllMessage(request: Chat.GetAllMessagesRequest): Chat.GetAllMessagesResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetAllMessage)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val chat = chatRepository.findById(request.chatId.uuid()).orElseThrow()
                chat.toAllMessages(userId).also { it ->
                    log.info("get messages: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun deleteMessage(request: Chat.DeleteChatRequest): UserOuterClass.IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteMessage)
            runWithTracing(span) {
                messageRepository.deleteById(request.chatId.uuid())
                successGrpc().also { it ->
                    log.info("deleted message: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override fun sendMessage(requests: Flow<SendMessageRequest>): Flow<Chat.Message> = flow {
        runWithTracing(tracer, SendMessage) {
            requests.collect { request ->
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val user = userRepository.findById(request.receiver.uuid()).orElseThrow()
                val chat = chatRepository.findById(request.chatId.uuid()).orElseThrow()
                val message = chat.addMessage(request.message, user)
                chatRepository.save(chat)
                try {
                    val to = chat.members.first { userId != request.receiver.uuid() }
                    if (to.notify) {
                        val token = tokenRepository.findByUserId(to.id).get()

                        val fireMessage: Message = Message.builder()
                            .setToken(fmcProvider.decrypt(token.deviceToken))
                            .putData("id", chat.id.toString())
                            .setNotification(
                                Notification.builder()
                                    .setTitle("Новое сообщение от ${user.name}")
                                    .setBody(request.message)
                                    .build()
                            )
                            .build()
                        firebaseMessaging.send(fireMessage)
                        log.info("send notification ${message.id}")
                    }
                } catch (ex: FirebaseMessagingException) {
                    log.error("error send notification ${message.id}")
                } finally {
                    emit(message.toMessageGrpc())
                }
            }
        }
    }

    companion object {
        private val log = LoggerFactory.getLogger(ChatService::class.java)
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