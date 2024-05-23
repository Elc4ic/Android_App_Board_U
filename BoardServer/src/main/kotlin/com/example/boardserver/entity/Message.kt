package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "messages")
class Message (
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    var content: String,
)