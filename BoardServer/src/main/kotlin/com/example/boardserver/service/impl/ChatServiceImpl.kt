package com.example.boardserver.service.impl

import board.Chat
import board.Chat.RepeatedChatPreview
import board.Chat.SendMessageRequest
import board.UserOuterClass
import brave.Tracer
import com.example.boardserver.entity.*
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.repository.*
import com.example.boardserver.service.ChatService
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.runWithTracing
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.FirebaseMessagingException
import com.google.firebase.messaging.Message
import com.google.firebase.messaging.Notification
import io.grpc.Context
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional


@Service
class ChatServiceImpl(
    private val chatRepository: ChatRepository,
    private val messageRepository: MessageRepository,
    private val userRepository: UserRepository,
    private val tokenRepository: TokenRepository,
    private val adRepository: AdRepository,
    private val fmcProvider: FcmProvider,
    private val firebaseMessaging: FirebaseMessaging,
    private val tracer: Tracer
) : ChatService {

    @Transactional
    override suspend fun startChat(request: Chat.StartRequest): Chat.StartResponse =
        runWithTracing(tracer, StartChat) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val ownerId = request.ad.user.id.uuid()
            if (userId == ownerId) throw IllegalArgumentException("Нельзя начать чат с самим собой")
            val adId = request.ad.id.uuid()
            val chat = chatRepository.findChatBetweenUsersByIds(ownerId, userId, adId).orElseGet {
                val user1 = userRepository.findUserWithChats(ownerId).orElseThrow()
                val user2 = userRepository.findUserWithChats(userId).orElseThrow()
                val ad = adRepository.findById(adId).orElseThrow()
                val chat = ad.createChat(user1, user2)
                user1.addChat(chat)
                user2.addChat(chat)
                chat.addUnreadCounter(user1)
                chat.addUnreadCounter(user2)
                userRepository.save(user1)
                userRepository.save(user2)
                chatRepository.save(chat)
            }
            chat.toStartResponse()
        }

    @Transactional
    override suspend fun deleteChat(request: Chat.DeleteChatRequest): UserOuterClass.IsSuccess =
        runWithTracing(tracer, DeleteChat) {
            chatRepository.deleteById(request.chatId.uuid())
            successGrpc(true)
        }

    override suspend fun getChatsPreview(request: UserOuterClass.Empty): RepeatedChatPreview =
        runWithTracing(tracer, GetChatPreview) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val chats = (chatRepository.findByMembersId(userId).orElse(emptySet()))
                .sortedByDescending { chat -> chat.lastMessage?.data }
            RepeatedChatPreview.newBuilder()
                .addAllChats(chats.toRepeatedChat(userId))
                .build()
        }

    @Transactional
    override suspend fun getAllMessage(request: Chat.GetAllMessagesRequest): Chat.GetAllMessagesResponse =
        runWithTracing(tracer, GetAllMessage) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val chat = chatRepository.findChatWithMessage(request.chatId.uuid()).orElseThrow()
            chat.memberUnreadCounters.forEach { if (it.user?.id != userId) it.count = 0 }
            chatRepository.save(chat)
            chat.toAllMessages(userId)
        }

    @Transactional
    override suspend fun deleteMessage(request: Chat.DeleteChatRequest): UserOuterClass.IsSuccess =
        runWithTracing(tracer, DeleteMessage) {
            messageRepository.deleteById(request.chatId.uuid())
            successGrpc(true)
        }

    @Transactional
    override fun sendMessage(requests: Flow<SendMessageRequest>): Flow<Chat.Message> = flow {
        requests.collect { request ->
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val user = userRepository.findById(request.receiver.uuid()).orElseThrow()
            val chat = chatRepository.findChatWithMessage(request.chatId.uuid()).orElseThrow()
            val message = chat.addMessage(request.message, user)
            chat.memberUnreadCounters.forEach { if (it.user?.id != userId) it.incrementCount() }
            chatRepository.save(chat)
            try {
                val to = chat.members.first { userId != it.id }
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
            } catch (e: Exception) {
                log.error(e.toString())
            } finally {
                emit(message.toMessageGrpc().also { log.info(it.toString()) })
            }
        }
    }


    companion object {
        private val log = LoggerFactory.getLogger(ChatServiceImpl::class.java)

        private const val chatService = "ChatService"
        private const val GetChatPreview = "$chatService.getChatService"
        private const val GetAllMessage = "$chatService.getAllMessage"
        private const val StartChat = "$chatService.startChat"
        private const val SendMessage = "$chatService.SendMessage"
        private const val DeleteChat = "$chatService.deleteChat"
        private const val DeleteMessage = "$chatService.deleteMessage"
    }
}