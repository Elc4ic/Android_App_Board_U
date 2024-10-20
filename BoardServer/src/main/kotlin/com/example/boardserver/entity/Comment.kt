package com.example.boardserver.entity

import board.UserOuterClass
import jakarta.persistence.*

@Entity
@Table(name = "comments")
class Comment(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long,
    var rating: Int,
    val text: String,
    val created: String,

    @ManyToOne
    @JoinColumn(name = "convicted_id")
    val convicted: User,

    @ManyToOne
    @JoinColumn(name = "creator_id")
    val creator: User,
)

fun Comment.toCommentGrpc(): UserOuterClass.Comment {
    return UserOuterClass.Comment.newBuilder()
        .setId(this.id)
        .setText(this.text)
        .setRating(this.rating)
        .setCreated(this.created)
        .setConvicted(this.convicted.toUserGrpc())
        .setOwner(this.creator.toUserGrpc())
        .build()
}

fun UserOuterClass.Comment.fromCommentGrpc(
    owner: User,
    convicted: User,
): Comment {
    return Comment(
        id = this.id,
        text = this.text,
        rating = this.rating,
        created = this.created,
        creator = owner,
        convicted = convicted
    )
}

fun List<Comment>.toRepeatedCommentGrpc(): UserOuterClass.CommentsResponse {
    val comments = mutableListOf<UserOuterClass.Comment>()
    this.forEach { comment -> comments.add(comment.toCommentGrpc()) }
    return UserOuterClass.CommentsResponse.newBuilder().addAllComments(comments).build()
}