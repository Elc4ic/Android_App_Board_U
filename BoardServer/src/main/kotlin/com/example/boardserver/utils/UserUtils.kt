package com.example.boardserver.utils

import at.favre.lib.crypto.bcrypt.BCrypt
import board.UserOuterClass
import com.example.boardserver.entity.User

object UserUtils {
    fun fromUserGrpc(user: UserOuterClass.User): User {
        return User(
            id = user.id,
            username = user.username,
            password = user.password,
            email = user.email,
            token = user.token,
            address = user.address,
            avatar = user.avatar,
        )
    }

    fun toUserGrpc(user: User): UserOuterClass.User {
        return UserOuterClass.User.newBuilder()
            .setId(user.id)
            .setUsername(user.username)
            .setPassword(user.password)
            .setEmail(user.email)
            .setToken(user.token)
            .setAddress(user.address)
            .setAvatar(user.avatar)
            .build()
    }

    fun hashPassword(password: String): String {
        return BCrypt.withDefaults().hash(10, password.toByteArray(Charsets.UTF_8)).toString()
    }

    fun checkPassword(input: String, user: String): Boolean {
        return !BCrypt.verifyer()
            .verify(
                input.toByteArray(Charsets.UTF_8),
                user.toByteArray(Charsets.UTF_8)
            ).verified
    }
}