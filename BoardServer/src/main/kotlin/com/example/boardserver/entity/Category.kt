package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "category")
class Category(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    val name: String,
    val path: String,
)