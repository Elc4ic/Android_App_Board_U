package com.example.boardserver.entity

import at.favre.lib.crypto.bcrypt.BCrypt
import board.UserOuterClass
import jakarta.persistence.*
import java.util.*

enum class Role { USER, MODER, ADMIN }

@Entity
@Table(name = "users")
data class User(
    @Id val id: UUID? = null,
    val name: String = "",
    val username: String = "",
    val password: String = "",
    val email: String = "",
    val phone: String = "",
    val address: String = "",
    val notify: Boolean = true,

    @Column(name = "is_online")
    var isOnline: Boolean = false,

    @Enumerated(EnumType.STRING)
    val role: Role = Role.USER,

    @OneToOne(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    @JoinColumn(name = "avatar_id")
    var avatar: UserImage? = null,

    @OneToOne(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    var deviceToken: DeviceToken? = null,

    @OneToMany(mappedBy = "user")
    var chatUnreadCounters: Set<UnreadCounter> = setOf(),

    @OneToMany(mappedBy = "convicted", cascade = [CascadeType.ALL], orphanRemoval = true)
    var comments: Set<Comment> = emptySet(),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    @Column(name = "my_ads")
    var myAds: Set<Ad> = emptySet(),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    @Column(name = "fav_ads")
    var favAds: Set<Favorites> = emptySet(),

    @ManyToMany(mappedBy = "members", cascade = [CascadeType.ALL])
    var chats: Set<Chat> = emptySet()
) {
    fun addFav(child: Favorites) {
        favAds = favAds.plus(child)
        child.user = this
    }

    fun addChat(child: Chat) {
        chats = chats.plus(child)
        child.members.plus(this)
    }

    fun addComment(child: Comment) {
        comments = comments.plus(child)
        child.convicted = this
    }

    fun addAd(child: Ad) {
        myAds = myAds.plus(child)
        child.user = this
    }

    fun addAvatar(child: UserImage) {
        avatar = child
        child.user = this
    }

    fun addDeviceToken(child: DeviceToken) {
        deviceToken = child
        child.user = this
    }
}


fun UserOuterClass.User.fromUserGrpc(): User {
    return User(
        name = this.name,
        username = this.username,
        password = this.password,
        email = this.email,
        address = this.address,
        phone = this.phone,
        notify = this.notify
    )
}

fun User.toUserGrpc(): UserOuterClass.User {
    val rating = this.comments.sumOf { it.rating }.toFloat() / this.comments.size
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setName(this.name)
        .setUsername(this.username)
        .setEmail(this.email)
        .setPhone(this.phone)
        .setPassword(this.password)
        .setAddress(this.address)
        .setRating(rating)
        .build()
}

fun User.toUserMini(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setName(this.name)
        .build()
}

fun User.toAnotherUser(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setName(this.name)
        .setEmail(this.email)
        .setPhone(this.phone)
        .setAddress(this.address)
        .build()
}

fun User.toUserPreview(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setAddress(this.address)
        .build()
}

fun User.toUserId(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setAddress(this.address)
        .build()
}

fun User.toUserChatPreview(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setName(this.name)
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