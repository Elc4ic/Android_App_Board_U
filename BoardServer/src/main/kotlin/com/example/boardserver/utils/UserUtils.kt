package com.example.boardserver.utils

import at.favre.lib.crypto.bcrypt.BCrypt
import board.UserOuterClass
import com.example.boardserver.entity.User
import com.google.protobuf.kotlin.toByteString

object UserUtils {
    fun fromUserGrpc(user: UserOuterClass.User): User {
        return User(
            id = user.id,
            name = user.name,
            username = user.username,
            password = user.password,
            email = user.email,
            address = user.address,
            avatar = user.avatar.toByteArray(),
            phone = user.phone,
            ratingAll = user.ratingAll,
            ratingNum = user.ratingNum,
        )
    }

    fun toUserGrpc(user: User): UserOuterClass.User {
        return UserOuterClass.User.newBuilder()
            .setId(user.id)
            .setName(user.name)
            .setUsername(user.username)
            .setPassword(user.password)
            .setEmail(user.email)
            .setPhone(user.phone)
            .setAddress(user.address)
            .setAvatar(user.avatar.toByteString())
            .setRatingAll(user.ratingAll)
            .setRatingNum(user.ratingNum)
            .build()
    }

    fun hashPassword(password: String): String {
        return BCrypt.withDefaults().hashToString(8, password.toCharArray())
    }

    fun checkPassword(input: String, user: String): Boolean {
        return BCrypt.verifyer()
            .verify(
                input.toCharArray(),
                user.toCharArray()
            ).verified
    }

    fun successGrpc(): UserOuterClass.IsSuccess {
        return UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
    }

    fun failGrpc(): UserOuterClass.IsSuccess {
        return UserOuterClass.IsSuccess.newBuilder().setLogin(false).build()
    }

}