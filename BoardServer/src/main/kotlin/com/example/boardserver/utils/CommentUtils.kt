package com.example.boardserver.utils

import board.UserOuterClass
import board.UserOuterClass.CommentsResponse
import com.example.boardserver.entity.Comment
import com.example.boardserver.entity.User

object CommentUtils {

    fun toCommentGrpc(comment: Comment): UserOuterClass.Comment {
        return UserOuterClass.Comment.newBuilder()
            .setId(comment.id)
            .setText(comment.text)
            .setRating(comment.rating)
            .setCreated(comment.created)
            .setConvicted(UserUtils.toUserGrpc(comment.convicted))
            .setOwner(UserUtils.toUserGrpc(comment.owner))
            .build()
    }

    fun fromCommentGrpc(
        comment: UserOuterClass.Comment,
        owner: User,
        convicted: User,
    ): Comment {
        return Comment(
            id = comment.id,
            text = comment.text,
            rating = comment.rating,
            created = comment.created,
            owner = owner,
            convicted = convicted
        )
    }

    fun toRepeatedCommentGrpc(commentList: List<Comment>): CommentsResponse {
        val comments = mutableListOf<UserOuterClass.Comment>()
        commentList.forEach { comment -> comments.add(toCommentGrpc(comment)) }
        return CommentsResponse.newBuilder().addAllComments(comments).build()
    }
}