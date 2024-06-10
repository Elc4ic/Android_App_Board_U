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