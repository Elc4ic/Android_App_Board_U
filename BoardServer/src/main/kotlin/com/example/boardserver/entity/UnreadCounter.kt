package com.example.boardserver.entity

import com.example.boardserver.repository.UnreadCounterRepository
import jakarta.persistence.*
import java.util.*


@Entity
@Table(name = "unread_counter")
class UnreadCounter(
    @GeneratedValue(strategy = GenerationType.UUID)
    @Id val id: UUID? = null,

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
        chat = chat,
        user = member
    )
    val saved = this.save(counter)
    chat.addUnreadCounter(saved)
}