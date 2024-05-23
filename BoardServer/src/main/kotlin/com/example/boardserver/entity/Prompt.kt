package com.example.boardserver.entity

import jakarta.persistence.*

@Entity
@Table(name = "prompts")
class Prompt(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    var title: String,
    var reward: Long,
    var description: String,
    var is_active: Boolean = true,
    var views: Int = 0,
    var address: String,
    var created: String,

    @ElementCollection
    val images: List<String>,

    @ManyToOne
    @JoinColumn(name = "owner_id")
    val owner: User,

    @ManyToOne
    @JoinColumn(name = "performer_id")
    val performer: User,
)