package com.example.boardserver.entity

import com.example.boardserver.repository.UnreadCounterRepository
import jakarta.persistence.*
import java.util.*


@Entity
@Table(name = "unread_counter")
class UnreadCounter(
    @Id val id: UUID,

    @ManyToOne
    @JoinColumn(name = "chat_id")
    var chat: Chat? = null,

    @ManyToOne
    @JoinColumn(name = "user_id")
    var user: User? = null,

    val count: Int = 0
)

fun UnreadCounterRepository.addUnreadCounter(chat: Chat, member: User?) {
    val counter = UnreadCounter(
        id = UUID.randomUUID(),
        chat = chat,
        user = member
    )
    val saved = this.save(counter)
    chat.addUnreadCounter(saved)
}