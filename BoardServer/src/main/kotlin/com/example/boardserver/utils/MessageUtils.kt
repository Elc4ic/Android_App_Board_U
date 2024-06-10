package com.example.boardserver.utils

import com.example.boardserver.entity.Chat
import com.example.boardserver.entity.Message
import com.example.boardserver.entity.User

object MessageUtils {
    fun toMessageGrpc(message: Message): board.Chat.Message {
        return board.Chat.Message.newBuilder()
            .setId(message.id)
            .setMessage(message.content)
            .setCreatedAt(message.data)
            .setSender(UserUtils.toUserGrpc(message.user))
            .build()
    }

    fun createMessageGrpc(context: String, receiver: User, data: String): board.Chat.Message {
        return board.Chat.Message.newBuilder()
            .setMessage(context)
            .setCreatedAt(data)
            .setSender(UserUtils.toUserGrpc(receiver))
            .build()
    }


    fun fromMessageGrpc(message: board.Chat.Message, chat: Chat): Message {
        return Message(
            id = message.id,
            content = message.message,
            data = message.createdAt,
            chat = chat,
            user = UserUtils.fromUserGrpc(message.sender),
        )
    }

    fun toMessageList(message: List<Message>): List<board.Chat.Message> {
        val messageGrpc = mutableListOf<board.Chat.Message>()
        message.forEach { c -> messageGrpc.add(toMessageGrpc(c)) }
        return messageGrpc
    }
}