package com.example.boardserver.entity

import board.UserOuterClass
import jakarta.persistence.*
import org.hibernate.annotations.JdbcType
import org.hibernate.type.descriptor.jdbc.VarbinaryJdbcType
import java.util.*

@Entity
@Table(name = "avatars")
class UserImage(
    @Id val id: UUID,

    @OneToOne
    @JoinColumn(name = "user_id")
    var user: User,

    @Lob
    @JdbcType(value = VarbinaryJdbcType::class)
    @Column(columnDefinition = "bytea")
    val imageBytes: ByteArray
)

fun UserOuterClass.ImageProto.toUserAvatar(user: User): UserImage {
    return UserImage(
        id = UUID.randomUUID(),
        user = user,
        imageBytes = this.chunk.toByteArray(),
    )
}