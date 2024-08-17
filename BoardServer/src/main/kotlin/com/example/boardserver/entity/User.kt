package com.example.boardserver.entity

import jakarta.persistence.*
import org.hibernate.annotations.JdbcType
import org.hibernate.type.descriptor.jdbc.VarbinaryJdbcType

@Entity
@Table(name = "users")
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long = 0L,
    val name: String,
    val username: String,
    val password: String,
    val email: String,
    val phone: String,
    val address: String,
    @Lob
    @JdbcType(value = VarbinaryJdbcType::class)
    @Column(columnDefinition = "bytea")
    val avatar: ByteArray,
    val ratingAll: Int = 0,
    val ratingNum: Int = 0
)