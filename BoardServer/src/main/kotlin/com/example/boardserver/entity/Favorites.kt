package com.example.boardserver.entity

import jakarta.persistence.*
import java.util.*

@Entity
@Table(name = "favorites")
class Favorites (
    @Id val id: UUID? = null,

    @ManyToOne
    @JoinColumn(name = "user_id")
    var user: User,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad
)