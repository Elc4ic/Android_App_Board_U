package com.example.boardserver.entity

import board.UserOuterClass
import jakarta.persistence.*
import java.time.LocalDateTime
import java.util.*

@Entity
@Table(name = "comments")
class Comment(
    @GeneratedValue(strategy = GenerationType.UUID)
    @Id val id: UUID? = null,
    var rating: Int = 0,
    var text: String = "",
    val created: LocalDateTime? = null,

    @ManyToOne
    @JoinColumn(name = "convicted_id")
    var convicted: User,

    @ManyToOne
    @JoinColumn(name = "creator_id")
    val creator: User,
)

fun Comment.toCommentGrpc(): UserOuterClass.Comment {
    return UserOuterClass.Comment.newBuilder()
        .setId(this.id.toString())
        .setText(this.text)
        .setRating(this.rating)
        .setCreated(this.created.toString())
        .setConvicted(this.convicted.toUserMini())
        .setOwner(this.creator.toUserMini())
        .build()
}

fun UserOuterClass.Comment.fromCommentGrpc(convicted: User, creator: User): Comment {
    return Comment(
        text = this.text,
        rating = this.rating,
        created = try {
            LocalDateTime.parse(this.created)
        } catch (e: Exception) {
            LocalDateTime.now()
        },
        creator = creator,
        convicted = convicted
    )
}

fun List<Comment>.toRepeatedCommentGrpc(): UserOuterClass.CommentsResponse {
    return UserOuterClass.CommentsResponse.newBuilder()
        .addAllComments(this.map { it.toCommentGrpc() })
        .build()
}