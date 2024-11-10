package com.example.boardserver.entity

import board.Chat.GetAllMessagesResponse
import jakarta.persistence.*
import java.time.LocalDateTime
import java.util.*

@Entity
@Table(name = "chats")
class Chat(
    @GeneratedValue(strategy = GenerationType.UUID)
    @Id val id: UUID? = null,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad,

    @ManyToMany(
        fetch = FetchType.EAGER,
        cascade = [
            CascadeType.DETACH,
            CascadeType.MERGE,
            CascadeType.PERSIST,
            CascadeType.REFRESH
        ],
    )
    @JoinTable(
        name = "chat_members",
        joinColumns = [JoinColumn(name = "chat_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "user_id", referencedColumnName = "id")]
    )
    val members: MutableSet<User> = mutableSetOf(),

    @OneToOne(orphanRemoval = true)
    @JoinColumn(name = "last_message_id")
    val lastMessage: Message? = null,

    @OneToMany(mappedBy = "chat", cascade = [CascadeType.REMOVE], orphanRemoval = true)
    var messages: MutableList<Message> = mutableListOf(),

    @OneToMany(mappedBy = "chat", orphanRemoval = true, cascade = [CascadeType.REMOVE])
    var memberUnreadCounters: MutableSet<UnreadCounter> = mutableSetOf()
) {

    fun addUnreadCounter(child: UnreadCounter) {
        memberUnreadCounters += child
        child.chat = this
    }

    fun addMessage(content: String, creator: User): Message {
        val message = Message(
            content = content,
            data = LocalDateTime.now(),
            chat = this,
            user = creator,
        )
        message.chat = this
        messages += message
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

fun Ad.createChat(user1: User, user2: User): Chat {
    return Chat(
        ad = this,
        members = mutableSetOf(user1, user2),
    )
}

fun List<Chat>.toRepeatedChat(userId: UUID): List<board.Chat.ChatPreview> {
    return this.map { it.toChatGrpc(userId) }
}

fun Chat.toAllMessages(userId: UUID): GetAllMessagesResponse {
    return GetAllMessagesResponse.newBuilder()
        .addAllMessages(this.messages.toMessageList())
        .setChat(this.toChatGrpc(userId))
        .build()
}

fun Chat.toStartResponse(): board.Chat.StartResponse =
    board.Chat.StartResponse.newBuilder().setChatId(this.id.toString()).build()
