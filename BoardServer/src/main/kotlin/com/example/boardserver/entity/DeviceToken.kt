package com.example.boardserver.entity

import jakarta.persistence.*
import java.util.*

@Entity
@Table(name = "tokens")
class DeviceToken(
    @GeneratedValue(strategy = GenerationType.UUID)
    @Id val id: UUID? = null,

    @OneToOne
    @JoinColumn(name = "user_id")
    var user: User,

    val deviceToken: String = "",
)

fun String.uuid(): UUID = UUID.fromString(this)


fun String.uuidOrNull(): UUID? = try {
    UUID.fromString(this)
} catch (ex: Exception) {
    null
}
