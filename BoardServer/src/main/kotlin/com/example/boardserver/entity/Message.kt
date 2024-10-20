package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "messages")
class Message (
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    var content: String,
    val data: String,

    @ManyToOne
    @JoinColumn(name = "user_id")
    val user: User,

    @ManyToOne
    @JoinColumn(name = "chat_id")
    val chat: Chat,

)

fun Message.toMessageGrpc(): board.Chat.Message {
    return board.Chat.Message.newBuilder()
        .setId(this.id)
        .setMessage(this.content)
        .setCreatedAt(this.data)
        .setSender(this.user.toUserGrpc())
        .build()
}

fun createMessageGrpc(context: String, receiver: User, data: String): board.Chat.Message {
    return board.Chat.Message.newBuilder()
        .setMessage(context)
        .setCreatedAt(data)
        .setSender(receiver.toUserGrpc())
        .build()
}


fun board.Chat.Message.fromMessageGrpc(chat: Chat): Message {
    return Message(
        id = this.id,
        content = this.message,
        data = this.createdAt,
        chat = chat,
        user = this.sender.fromUserGrpc(),
    )
}

fun  List<Message>.toMessageList(): List<board.Chat.Message> {
    val messageGrpc = mutableListOf<board.Chat.Message>()
    this.forEach { c -> messageGrpc.add(c.toMessageGrpc()) }
    return messageGrpc
}