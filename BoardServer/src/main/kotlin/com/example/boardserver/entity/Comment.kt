package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "comments")
class Comment(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    var rating: Int,
    val text: String,
    val created: String,

    @ManyToOne
    @JoinColumn(name = "convicted_id")
    val convicted: User,

    @ManyToOne
    @JoinColumn(name = "creator_id")
    val creator: User,
)