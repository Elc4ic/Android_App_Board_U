package com.example.boardserver.service

import board.Chat
import board.Chat.RepeatedChatPreview
import board.Chat.SendMessageRequest
import board.UserOuterClass
import com.example.boardserver.entity.*
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.ChatRepository
import com.example.boardserver.repository.MessageRepository
import com.example.boardserver.repository.TokenRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.runWithTracing
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.FirebaseMessagingException
import com.google.firebase.messaging.Message
import com.google.firebase.messaging.Notification
import io.grpc.Context
import io.opentelemetry.api.trace.Tracer
import io.opentelemetry.extension.kotlin.asContextElement
import jakarta.transaction.Transactional
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.data.domain.Sort
import com.example.boardserver.entity.Chat as EntityChat


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
            val span = tracer.spanBuilder(StartChat).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    val user = userRepository.findById(userId).get()
                    val chat: EntityChat
                    if (chatRepository.countByOwnerIdAndReceiverIdAndAdId(
                            request.ad.user.id,
                            user.id,
                            request.ad.id
                        ) == 0L
                    ) {
                        chat = request.ad.createChatGrpc(request.ad.user, user)
                        chatRepository.save(chat)
                    } else {
                        chat = chatRepository.findByOwnerIdAndReceiverIdAndAdId(request.ad.user.id, user.id, request.ad.id)
                            .get()
                    }
                    val response = Chat.StartResponse.newBuilder().setChatId(chat.id).build()
                    response.also { it ->
                        log.info("start chat: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    @Transactional
    override suspend fun deleteChat(request: Chat.DeleteChatRequest): UserOuterClass.Empty =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(DeleteChat).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    messageRepository.deleteAllByChatId(request.chatId)
                    chatRepository.deleteById(request.chatId)
                    UserOuterClass.Empty.getDefaultInstance().also { it ->
                        log.info("delete chat: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }


    override suspend fun getChatsPreview(request: UserOuterClass.Empty): RepeatedChatPreview =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetChatPreview).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    val chats = chatRepository.findByOwnerId(userId, Sort.by(Sort.Direction.DESC, "lastMessage.data"))
                    val response = RepeatedChatPreview.newBuilder()
                        .addAllChats(chats.toRepeatedChat())
                        .build()
                    response.also { it ->
                        log.info("get chats: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }


    override suspend fun getAllMessage(request: Chat.GetAllMessagesRequest): Chat.GetAllMessagesResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetAllMessage).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val chat = chatRepository.findById(request.chatId).get()
                    val message = messageRepository.findByChatId(request.chatId)
                    val response = Chat.GetAllMessagesResponse.newBuilder()
                        .addAllMessages(message.toMessageList())
                        .setChat(chat.toChatGrpc())
                        .build()
                    response.also { it ->
                        log.info("get messages: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }


    override suspend fun deleteMessage(request: Chat.DeleteChatRequest): UserOuterClass.Empty =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(DeleteMessage).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    messageRepository.deleteById(request.chatId)
                    val response = UserOuterClass.Empty.getDefaultInstance()
                    response.also { it ->
                        log.info("deleted message: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }

        }


    override fun sendMessage(requests: Flow<SendMessageRequest>): Flow<Chat.Message> = flow {
        runWithTracing(tracer, SendMessage) {
            requests.collect { request ->
                val user = userRepository.findById(request.receiver).get()
                val message = createMessageGrpc(request.message, user, request.data)
                val chat = chatRepository.findById(request.chatId).get()
                val messageEntity = message.fromMessageGrpc(chat)
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

        private const val chatService = "ChatAPI"
        private const val GetChatPreview = "$chatService.getChatService"
        private const val GetAllMessage = "$chatService.getAllMessage"
        private const val StartChat = "$chatService.startChat"
        private const val SendMessage = "$chatService.SendMessage"
        private const val DeleteChat = "$chatService.deleteChat"
        private const val DeleteMessage = "$chatService.deleteMessage"
    }
}