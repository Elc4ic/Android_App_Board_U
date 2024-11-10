package com.example.boardserver.entity

import board.UserOuterClass
import jakarta.persistence.*
import org.hibernate.annotations.JdbcType
import org.hibernate.type.descriptor.jdbc.VarbinaryJdbcType
import java.util.*

@Entity
@Table(name = "avatars")
class UserImage(
    @GeneratedValue(strategy = GenerationType.UUID)
    @Id val id: UUID? = null,

    @OneToOne
    @JoinColumn(name = "user_id")
    var user: User? = null,

    @Lob
    @JdbcType(value = VarbinaryJdbcType::class)
    @Column(columnDefinition = "bytea")
    val imageBytes: ByteArray
)

fun UserOuterClass.ImageProto.fromAvatarGrpc(user: User): UserImage {
    return UserImage(
        user = user,
        imageBytes = this.chunk.toByteArray(),
    )
}