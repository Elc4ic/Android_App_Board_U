package com.example.boardserver.entity

import jakarta.persistence.*
import org.hibernate.annotations.JdbcType
import org.hibernate.type.descriptor.jdbc.VarbinaryJdbcType
import java.util.*

@Entity
@Table(name = "avatars")
class UserImage(
    @Id val id: UUID? = null,

    @OneToOne
    @JoinColumn(name = "user_id")
    val user: User,

    @Lob
    @JdbcType(value = VarbinaryJdbcType::class)
    @Column(columnDefinition = "bytea")
    val imageBytes: ByteArray
)