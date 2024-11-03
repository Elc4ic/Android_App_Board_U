package com.example.boardserver.entity

import jakarta.persistence.*
import java.time.LocalDateTime
import java.util.*

@Entity
@Table(name = "messages")
class Message(
    @Id val id: UUID? = null,
    var content: String,
    val data: LocalDateTime? = null,

    @ManyToOne
    @JoinColumn(name = "user_id")
    val user: User,

    @ManyToOne
    @JoinColumn(name = "chat_id")
    var chat: Chat
)

fun Message.toMessageGrpc(): board.Chat.Message {
    return board.Chat.Message.newBuilder()
        .setId(this.id.toString())
        .setMessage(this.content)
        .setCreatedAt(this.data.toString())
        .setSender(this.user.toUserId())
        .build()
}

fun List<Message>.toMessageList(): List<board.Chat.Message> {
    val messageGrpc = mutableListOf<board.Chat.Message>()
    this.forEach { c -> messageGrpc.add(c.toMessageGrpc()) }
    return messageGrpc
}