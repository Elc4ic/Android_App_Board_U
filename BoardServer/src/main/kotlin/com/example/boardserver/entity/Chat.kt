package com.example.boardserver.entity

import board.AdOuterClass
import board.UserOuterClass
import jakarta.persistence.*

@Entity
@Table(name = "chats")
class Chat(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long = 0,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad,

    @OneToOne
    @JoinColumn(name = "message_id")
    var lastMessage: Message? = null,

    @ManyToOne
    @JoinColumn(name = "owner_id")
    val owner: User,

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    val receiver: User,
)

fun Chat.toChatGrpc(): board.Chat.ChatPreview {
    return board.Chat.ChatPreview.newBuilder()
        .setId(this.id)
        .setAd(this.ad.toAdGrpc())
        .setLastMessage(this.lastMessage!!.toMessageGrpc())
        .setTarget(this.receiver.toUserGrpc())
        .build()
}

fun AdOuterClass.Ad.createChatGrpc(target: UserOuterClass.User, user: User): Chat {
    return Chat(
        ad = this.fromAdGrpc(),
        owner = target.fromUserGrpc(),
        receiver = user,
    )
}

fun List<Chat>.toRepeatedChat(): List<board.Chat.ChatPreview> {
    val chatsGrpc = mutableListOf<board.Chat.ChatPreview>()
    this.forEach { c -> chatsGrpc.add(c.toChatGrpc()) }
    return chatsGrpc
}