package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "chats")
class Chat(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long = 0,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad,

    @ManyToOne
    @JoinColumn(name = "owner_id")
    val owner: User,

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    val receiver: User,
)