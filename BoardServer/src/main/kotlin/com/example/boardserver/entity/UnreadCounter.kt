package com.example.boardserver.entity

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

    var count: Int = 0
){
    fun resetCount() {
        count = 0
    }

    fun incrementCount() {
        count++
    }
}

fun Chat.addUnreadCounter(member: User?) {
    val counter = UnreadCounter(
        chat = this,
        user = member
    )
    this.addUnreadCounter(counter)
}



