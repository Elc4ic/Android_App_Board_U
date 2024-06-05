package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "chats")
class Chat (
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad,


)