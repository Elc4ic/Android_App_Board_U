package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "ads")
class Ad(
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    val id: String,
    var title: String,
    var price: Long,
    var description: String? = null,
    var is_favorite: Boolean = false,

    @ManyToOne
    @JoinColumn(name = "category_id")
    val category: Category?
)