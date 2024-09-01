package com.example.boardserver.entity
import jakarta.persistence.*

@Entity
@Table(name = "tokens")
class DeviceToken (
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long = 0,

    @OneToOne
    @JoinColumn(name = "user_id")
    val user: User,

    val deviceToken: String,
)
