package com.example.boardserver.entity

import jakarta.persistence.*


@Entity
@Table(name = "unread_counter")
class UnreadCounter {
    @EmbeddedId
    private val id: ChatUserKey = ChatUserKey()

    @ManyToOne
    @MapsId("chatId")
    @JoinColumn(name = "chat_id")
    private val chat: Chat? = null

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private val user: User? = null

    @Column(name = "count")
    private val count = 0
}