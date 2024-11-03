package com.example.boardserver.entity

import jakarta.persistence.Column
import jakarta.persistence.Embeddable
import java.io.Serializable
import java.util.*

@Embeddable
class ChatUserKey : Serializable {
    @Column(name = "user_id")
    private val userId: Long? = null

    @Column(name = "chat_id")
    private val chatId: Long? = null

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other !is ChatUserKey) return false

        return (userId != null && userId == other.userId) &&
                (chatId != null && chatId == other.chatId)
    }

    override fun hashCode(): Int {
        return Objects.hash(userId, chatId)
    }
}