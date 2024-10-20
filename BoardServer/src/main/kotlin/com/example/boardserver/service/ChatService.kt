package com.example.boardserver.service

import board.AdOuterClass
import board.Chat
import board.Chat.RepeatedChatPreview
import board.Chat.SendMessageRequest
import board.UserOuterClass
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.ChatRepository
import com.example.boardserver.repository.MessageRepository
import com.example.boardserver.repository.TokenRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.*
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.FirebaseMessagingException
import com.google.firebase.messaging.Message
import com.google.firebase.messaging.Notification
import io.grpc.Status
import io.micrometer.tracing.Tracer
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.data.domain.Sort
import org.springframework.transaction.annotation.Transactional
import com.example.boardserver.entity.Chat as EntityChat


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class ChatService(
    private val chatRepository: ChatRepository,
    private val messageRepository: MessageRepository,
    private val userRepository: UserRepository,
    private val tokenRepository: TokenRepository,
    private val jwtProvider: JwtProvider,
    private val fmcProvider: FcmProvider,
    private val firebaseMessaging: FirebaseMessaging,
    private val tracer: Tracer
) : board.ChatAPIGrpcKt.ChatAPICoroutineImplBase() {

    @Transactional
    override suspend fun startChat(request: Chat.StartRequest): Chat.StartResponse =
            withTimeout(timeOutMillis) {
                val span = tracer.startScopedSpan(StartChat)
                val userId = jwtProvider.validateJwt(request.token)
                if (userId != null) {
                    val user = userRepository.findById(userId).get()
                    var chat: EntityChat
                    if (chatRepository.countByOwnerIdAndReceiverIdAndAdId(
                            request.ad.user.id,
                            user.id,
                            request.ad.id
                        ) == 0L
                    ) {
                        chat = ChatUtils.createChatGrpc(request.ad, request.ad.user, user)
                        chatRepository.save(chat)
                    }
                    chat = chatRepository.findByOwnerIdAndReceiverIdAndAdId(request.ad.user.id, user.id, request.ad.id)
                        .get()
                    val response = Chat.StartResponse.newBuilder().setChatId(chat.id).build()
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("start chat: $it").also { span.tag("response", it.toString()) }
                        }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
                }
            }

    @Transactional
    override suspend fun deleteChat(request: Chat.DeleteChatRequest): AdOuterClass.Empty =
            withTimeout(timeOutMillis) {
                val span = tracer.startScopedSpan(DeleteChat)
                val userId = jwtProvider.validateJwt(request.token)
                if (userId != null) {
                    messageRepository.deleteAllByChatId(request.chatId)
                    chatRepository.deleteById(request.chatId)
                    val response = AdOuterClass.Empty.getDefaultInstance()
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("delete chat: $it").also { span.tag("response", it.toString()) }
                        }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
                }
            }



    override suspend fun getChatsPreview(request: UserOuterClass.JwtProto): RepeatedChatPreview =
            withTimeout(timeOutMillis) {
                val span = tracer.startScopedSpan(GetChatPreview)
                val userId = jwtProvider.validateJwt(request.token)
                if (userId != null) {
                    val chats = chatRepository.findByOwnerId(userId, Sort.by(Sort.Direction.DESC, "lastMessage.data"))
                    val response = RepeatedChatPreview.newBuilder()
                        .addAllChats(ChatUtils.toRepeatedChat(chats))
                        .build()
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("get chats: $it").also { span.tag("response", it.toString()) }
                        }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
                }
            }



    override suspend fun getAllMessage(request: Chat.GetAllMessagesRequest): Chat.GetAllMessagesResponse =
            withTimeout(timeOutMillis) {
                val span = tracer.startScopedSpan(GetAllMessage)
                val userId = jwtProvider.validateJwt(request.token)
                if (userId != null) {
                    val chat = chatRepository.findById(request.chatId).get()
                    val message = messageRepository.findByChatId(request.chatId)
                    val response = Chat.GetAllMessagesResponse.newBuilder()
                        .addAllMessages(MessageUtils.toMessageList(message))
                        .setChat(ChatUtils.toChatGrpc(chat))
                        .build()
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("get messages: $it").also { span.tag("response", it.toString()) }
                        }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
                }
            }



    @Transactional
    override suspend fun deleteMessage(request: Chat.DeleteChatRequest): AdOuterClass.Empty =
            withTimeout(timeOutMillis) {
                val span = tracer.startScopedSpan(DeleteMessage)
                val userId = jwtProvider.validateJwt(request.token)
                if (userId != null) {
                    messageRepository.deleteById(request.chatId)
                    val response = AdOuterClass.Empty.getDefaultInstance()
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("deleted message: $it").also { span.tag("response", it.toString()) }
                        }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.asException().also { log.error("Invalid token: $it") }
                }
            }



    @Transactional
    override fun sendMessage(requests: Flow<SendMessageRequest>): Flow<Chat.Message> = flow {
        runWithTracing(tracer, SendMessage) {
            requests.collect { request ->
                val user = userRepository.findById(request.receiver).get()
                val message = MessageUtils.createMessageGrpc(request.message, user, request.data)
                val chat = chatRepository.findById(request.chatId).get()
                val messageEntity = MessageUtils.fromMessageGrpc(message, chat)
                chat.lastMessage = messageEntity
                messageRepository.save(messageEntity)
                chatRepository.save(chat)
                try {
                    val to = if (chat.owner.id == request.receiver) chat.receiver.id else chat.owner.id
                    val token = tokenRepository.findByUserId(to)

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
                } catch (_: FirebaseMessagingException) {
                    log.error("error send notification ${message.id}")
                }
                emit(message)
            }
        }
    }

    companion object {
        private val log = LoggerFactory.getLogger(ChatService::class.java)
        private const val timeOutMillis = 5000L

        private const val GetChatPreview = "ChatService.getChatService"
        private const val GetAllMessage = "ChatService.getAllMessage"
        private const val StartChat = "ChatService.startChat"
        private const val SendMessage = "ChatService.SendMessage"
        private const val DeleteChat = "ChatService.deleteChat"
        private const val DeleteMessage = "ChatService.deleteMessage"
    }
}