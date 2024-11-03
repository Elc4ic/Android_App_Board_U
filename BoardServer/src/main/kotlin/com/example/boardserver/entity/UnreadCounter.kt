package com.example.boardserver.entity

import com.example.boardserver.repository.UnreadCounterRepository
import jakarta.persistence.*


@Entity
@Table(name = "unread_counter")
class UnreadCounter(
    @EmbeddedId
    val id: ChatUserKey = ChatUserKey(),

    @ManyToOne
    @MapsId("chatId")
    @JoinColumn(name = "chat_id")
    var chat: Chat? = null,

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    var user: User? = null,

    val count: Int = 0
)

fun UnreadCounterRepository.addUnreadCounter(chat: Chat, member: User?) {
    val counter = UnreadCounter(
        chat = chat,
        user = member
    )
    val saved = this.save(counter)
    chat.memberUnreadCounters.plus(saved)
}