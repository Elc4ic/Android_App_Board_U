package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "users")
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long = 0L,
    val username: String,
    val password: String,
    val email: String,
    val phone: String,
    val address: String,
    val avatar: String,

    @OneToMany(
        mappedBy = "performer",
        fetch = FetchType.EAGER,
        orphanRemoval = true,
        cascade = [CascadeType.ALL]
    )
    val taken_prompt: MutableList<Prompt> = mutableListOf(),

    @OneToMany(
        mappedBy = "owner",
        fetch = FetchType.EAGER,
        orphanRemoval = true,
        cascade = [CascadeType.ALL]
    )
    val my_prompt: MutableList<Prompt> = mutableListOf(),
)