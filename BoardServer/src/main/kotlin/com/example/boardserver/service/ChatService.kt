package com.example.boardserver.service

import board.AdOuterClass
import board.Chat
import board.Chat.RepeatedChatPreview
import board.Chat.SendMessageRequest
import board.UserOuterClass
import com.example.boardserver.repository.ChatRepository
import com.example.boardserver.repository.MessageRepository
import com.example.boardserver.repository.TokenRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.ChatUtils
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.MessageUtils
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.FirebaseMessagingException
import com.google.firebase.messaging.Message
import com.google.firebase.messaging.Notification
import io.grpc.Status
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService
import org.springframework.transaction.annotation.Transactional
import com.example.boardserver.entity.Chat as EntityChat


@GrpcService
class ChatService(
    private val chatRepository: ChatRepository,
    private val messageRepository: MessageRepository,
    private val userRepository: UserRepository,
    private val tokenRepository: TokenRepository,
    private val jwtProvider: JwtProvider,
    private val fmcProvider: FcmProvider,
    private val firebaseMessaging: FirebaseMessaging,
) : board.ChatAPIGrpc.ChatAPIImplBase() {

    override fun getChatsPreview(
        request: UserOuterClass.JwtProto?,
        responseObserver: StreamObserver<RepeatedChatPreview>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val chats = chatRepository.findByOwnerId(userId)
            responseObserver?.onNext(
                RepeatedChatPreview.newBuilder()
                    .addAllChats(ChatUtils.toRepeatedChat(chats))
                    .build()
            )
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun sendMessage(responseObserver: StreamObserver<Chat.Message>?): StreamObserver<SendMessageRequest> =
        object : StreamObserver<SendMessageRequest> {
            override fun onNext(request: SendMessageRequest) {
                val user = userRepository.findById(request.receiver).get()
                val message = MessageUtils.createMessageGrpc(request.message, user, request.data)
                val chat = chatRepository.findById(request.chatId).get()
                messageRepository.save(MessageUtils.fromMessageGrpc(message, chat))
                responseObserver?.onNext(message)
                try {
                    val to = if (chat.owner.id == request.receiver) chat.receiver.id else chat.owner.id
                    val token = tokenRepository.findByUserId(to)
                    println(fmcProvider.decrypt(token.deviceToken))
                    val fireMessage: Message = Message.builder()
                        .setToken(fmcProvider.decrypt(token.deviceToken))
                        .setNotification(
                            Notification.builder()
                                .setTitle("Новое сообщение от ${user.name}")
                                .setBody(request.message)
                                .build()
                        )
                        .build()
                    firebaseMessaging.send(fireMessage)
                    println("Message sent successfully")
                } catch (e: FirebaseMessagingException) {
                    println("Message sent error" + e.message)
                }
            }

            override fun onError(t: Throwable) {
                responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Ошибка отправки").asException())
            }

            override fun onCompleted() {
                responseObserver?.onCompleted();
            }
        }

    override fun getAllMessage(
        request: Chat.GetAllMessagesRequest?,
        responseObserver: StreamObserver<Chat.GetAllMessagesResponse>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val chat = chatRepository.findById(request.chatId).get()
            val message = messageRepository.findByChatId(request.chatId)
            responseObserver?.onNext(
                Chat.GetAllMessagesResponse.newBuilder()
                    .addAllMessages(MessageUtils.toMessageList(message))
                    .setChat(ChatUtils.toChatGrpc(chat))
                    .build()
            )
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun startChat(request: Chat.StartRequest?, responseObserver: StreamObserver<Chat.StartResponse>?) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val user = userRepository.findById(userId).get()
            var chat: EntityChat
            if (chatRepository.countByOwnerIdAndReceiverIdAndAdId(request.ad.user.id, user.id, request.ad.id) == 0L) {
                chat = ChatUtils.createChatGrpc(request.ad, request.ad.user, user)
                chatRepository.save(chat)
            }
            chat = chatRepository.findByOwnerIdAndReceiverIdAndAdId(request.ad.user.id, user.id, request.ad.id).get()
            responseObserver?.onNext(Chat.StartResponse.newBuilder().setChatId(chat.id).build())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun deleteChat(request: Chat.DeleteChatRequest?, responseObserver: StreamObserver<AdOuterClass.Empty>?) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            messageRepository.deleteAllByChatId(request.chatId)
            chatRepository.deleteById(request.chatId)
            responseObserver?.onNext(AdOuterClass.Empty.getDefaultInstance())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun deleteMessage(
        request: Chat.DeleteChatRequest?,
        responseObserver: StreamObserver<AdOuterClass.Empty>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            messageRepository.deleteById(request.chatId)
            responseObserver?.onNext(AdOuterClass.Empty.getDefaultInstance())
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }
}