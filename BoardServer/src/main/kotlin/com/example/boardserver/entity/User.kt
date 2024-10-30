package com.example.boardserver.entity

import at.favre.lib.crypto.bcrypt.BCrypt
import board.UserOuterClass
import com.fasterxml.jackson.annotation.JsonProperty
import com.google.protobuf.kotlin.toByteString
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
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    val password: String,
    val email: String,
    val phone: String,
    val address: String,
    @Lob
    @JdbcType(value = VarbinaryJdbcType::class)
    @Column(columnDefinition = "bytea")
    val avatar: ByteArray,
    var ratingAll: Int = 0,
    var ratingNum: Int = 0
)

fun UserOuterClass.User.fromUserGrpc(): User {
    return User(
        id = this.id,
        name = this.name,
        username = this.username,
        password = this.password,
        email = this.email,
        address = this.address,
        avatar = this.avatar.toByteArray(),
        phone = this.phone,
        ratingAll = this.ratingAll,
        ratingNum = this.ratingNum,
    )
}

fun User.toUserGrpc(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id)
        .setName(this.name)
        .setUsername(this.username)
        .setEmail(this.email)
        .setPhone(this.phone)
        .setAddress(this.address)
        .setAvatar(this.avatar.toByteString())
        .setRatingAll(this.ratingAll)
        .setRatingNum(this.ratingNum)
        .build()
}

fun User.toUserMini(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id)
        .setName(this.name)
        .setAvatar(this.avatar.toByteString())
        .setRatingAll(this.ratingAll)
        .setRatingNum(this.ratingNum)
        .build()
}

fun User.toAnotherUser(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id)
        .setName(this.name)
        .setEmail(this.email)
        .setPhone(this.phone)
        .setAddress(this.address)
        .setAvatar(this.avatar.toByteString())
        .setRatingAll(this.ratingAll)
        .setRatingNum(this.ratingNum)
        .build()
}

fun User.toUserPreview(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id)
        .setAddress(this.address)
        .build()
}

fun String.hashPassword(): String {
    return BCrypt.withDefaults().hashToString(8, this.toCharArray())
}

fun String.checkPassword(user: String): Boolean {
    return BCrypt.verifyer()
        .verify(
            this.toCharArray(),
            user.toCharArray()
        ).verified
}

fun successGrpc(): UserOuterClass.IsSuccess {
    return UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
}

fun failGrpc(): UserOuterClass.IsSuccess {
    return UserOuterClass.IsSuccess.newBuilder().setLogin(false).build()
}