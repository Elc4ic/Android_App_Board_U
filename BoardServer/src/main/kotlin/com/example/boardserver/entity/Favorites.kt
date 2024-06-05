package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "favorites")
class Favorites (
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long = 0,

    @ManyToOne
    @JoinColumn(name = "user_id")
    val user: User,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad
)