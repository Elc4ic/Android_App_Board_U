package com.example.boardserver.entity

import at.favre.lib.crypto.bcrypt.BCrypt
import board.UserOuterClass
import jakarta.persistence.*
import java.util.*

enum class Role { USER, MODER, ADMIN }

@Entity
@Table(name = "users")
class User(
    @GeneratedValue(strategy = GenerationType.UUID) @Id val id: UUID? = null,
    var name: String = "",
    var username: String = "",
    var password: String = "",
    var email: String = "",
    var phone: String = "",
    var address: String = "",
    var notify: Boolean = true,

    @Column(name = "is_online") var isOnline: Boolean = false,

    @Enumerated(EnumType.STRING) @Column(name = "role") val role: Role = Role.USER,

    @OneToOne(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true) var avatar: UserImage? = null,

    @OneToOne(
        mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true
    ) var deviceToken: DeviceToken? = null,

    @OneToMany(mappedBy = "user") var counters: Set<UnreadCounter> = setOf(),

    @OneToMany(
        mappedBy = "convicted", cascade = [CascadeType.ALL], orphanRemoval = true
    ) var comments: MutableSet<Comment> = mutableSetOf(),

    @OneToMany(
        mappedBy = "user", fetch = FetchType.LAZY, cascade = [CascadeType.ALL], orphanRemoval = true
    ) var ads: MutableSet<Ad> = mutableSetOf(),

    @ManyToMany(
        cascade = [CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH],
    ) @JoinTable(
        name = "fav_ads",
        joinColumns = [JoinColumn(name = "user_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "ad_id", referencedColumnName = "id")]
    ) val favs: MutableSet<Ad> = mutableSetOf(),

    @ManyToMany(
        mappedBy = "members",
        cascade = [CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH],
    ) var chats: MutableSet<Chat> = mutableSetOf()
) {

    fun addOrRemoveFav(child: Ad) {
        if (favs.any { it.id == child.id }) {
            favs.removeIf { it.id == child.id }
            child.favorites.removeIf { it.id == child.id }
        } else {
            favs.add(child)
            child.favorites.add(this)
        }
    }

    fun addChat(child: Chat) {
        chats.add(child)
    }

    fun addComment(child: Comment) {
        child.convicted = this
        comments.add(child)
    }

    fun addAd(child: Ad) {
        child.user = this
        ads.add(child)
    }

    fun addAvatar(child: UserImage) {
        child.user = this
        avatar = child
    }

    fun addDeviceToken(child: DeviceToken) {
        child.user = this
        deviceToken = child
    }
}

fun UserOuterClass.User.fromUserGrpc(new: Boolean = false): User {
    return User(
        id = if (new) null else UUID.fromString(this.id),
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
        .setRating(rating).build()
}

fun User.toUserMini(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setAddress(this.address)
        .setName(this.name).build()
}   

fun User.toAnotherUser(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setName(this.name)
        .setEmail(this.email)
        .setPhone(this.phone)
        .setAddress(this.address).build()
}

fun User.toUserPreview(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setAddress(this.address).build()
}

fun User.toUserId(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setAddress(this.address).build()
}

fun User.toUserChatPreview(): UserOuterClass.User {
    return UserOuterClass.User.newBuilder()
        .setId(this.id.toString())
        .setName(this.name).build()
}

fun String.hashPassword(): String {
    return BCrypt.withDefaults().hashToString(8, this.toCharArray())
}

fun String.checkPassword(user: String): Boolean {
    return BCrypt.verifyer().verify(
        this.toCharArray(), user.toCharArray()
    ).verified
}

fun successGrpc(): UserOuterClass.IsSuccess {
    return UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
}

fun failGrpc(): UserOuterClass.IsSuccess {
    return UserOuterClass.IsSuccess.newBuilder().setLogin(false).build()
}