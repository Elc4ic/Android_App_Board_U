package com.example.boardserver.entity

import board.AdOuterClass
import board.Chat.GetAllMessagesResponse
import board.UserOuterClass
import jakarta.persistence.*
import java.time.LocalDateTime
import java.util.*

@Entity
@Table(name = "chats")
data class Chat(
    @Id val id: UUID? = null,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad,

    @ManyToMany(
        fetch = FetchType.EAGER,
        cascade = [CascadeType.ALL]
    )
    @JoinTable(
        name = "chat_members",
        joinColumns = [JoinColumn(name = "route_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "route_id", referencedColumnName = "id")]
    )
    val members: Set<User> = linkedSetOf(),

    @OneToOne(orphanRemoval = true)
    @JoinColumn(name = "last_message_id")
    val lastMessage: Message? = null,

    @OneToMany(mappedBy = "chat", cascade = [CascadeType.REMOVE], orphanRemoval = true)
    var messages: List<Message> = emptyList(),

    @OneToMany(mappedBy = "chat", orphanRemoval = true, cascade = [CascadeType.REMOVE])
    var memberUnreadCounters: Set<UnreadCounter> = setOf()
) {
    fun addUnreadCounter(child: UnreadCounter) {
        memberUnreadCounters = memberUnreadCounters.plus(child)
        child.chat = this
    }

    fun addMessage(content: String, creator: User): Message {
        val message = Message(
            content = content,
            data = LocalDateTime.now(),
            chat = this,
            user = creator,
        )
        messages = messages.plus(message)
        message.chat = this
        return message
    }
}

fun Chat.toChatGrpc(userId: UUID): board.Chat.ChatPreview {
    return board.Chat.ChatPreview.newBuilder()
        .setId(this.id.toString())
        .setAd(this.ad.toAdPreview())
        .setTarget(this.members.first { it.id != userId }.toUserChatPreview())
        .setLastMessage(this.lastMessage?.toMessageGrpc() ?: board.Chat.Message.getDefaultInstance())
        .build()
}

fun AdOuterClass.Ad.createChat(target: UserOuterClass.User, user: User): Chat {
    return Chat(
        ad = this.fromAdGrpc(),
        members = setOf(user, target.fromUserGrpc()),
    )
}

fun Set<Chat>.toRepeatedChat(userId: UUID): List<board.Chat.ChatPreview> {
    val chatsGrpc = mutableListOf<board.Chat.ChatPreview>()
    this.forEach { c -> chatsGrpc.add(c.toChatGrpc(userId)) }
    return chatsGrpc
}

fun Chat.toAllMessages(userId: UUID): GetAllMessagesResponse {
    return GetAllMessagesResponse.newBuilder()
        .addAllMessages(this.messages.toMessageList())
        .setChat(this.toChatGrpc(userId))
        .build()
}

fun Chat.toStartResponse(): board.Chat.StartResponse =
    board.Chat.StartResponse.newBuilder().setChatId(this.id.toString()).build()
