package com.example.boardserver.utils

import board.AdOuterClass.Ad
import board.Chat.ChatPreview
import board.UserOuterClass.User
import com.example.boardserver.entity.Chat
import com.example.boardserver.entity.User as EntityUser

object ChatUtils {
    fun toChatGrpc(chat: Chat): ChatPreview {
        return ChatPreview.newBuilder()
            .setId(chat.id)
            .setAd(AdUtils.toAdGrpc(chat.ad))
            .setLastMessage(MessageUtils.toMessageGrpc(chat.lastMessage!!))
            .setTarget(UserUtils.toUserGrpc(chat.receiver))
            .build()
    }

    fun createChatGrpc(ad: Ad, target: User, user: EntityUser): Chat {
        return Chat(
            ad = AdUtils.fromAdGrpc(ad),
            owner = UserUtils.fromUserGrpc(target),
            receiver = user,
        )
    }

    fun toRepeatedChat(chat: List<Chat>): List<ChatPreview> {
        val chatsGrpc = mutableListOf<ChatPreview>()
        chat.forEach { c -> chatsGrpc.add(toChatGrpc(c)) }
        return chatsGrpc
    }
}