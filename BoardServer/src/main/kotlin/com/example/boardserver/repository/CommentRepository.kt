package com.example.boardserver.repository

import com.example.boardserver.entity.Comment
import org.springframework.data.jpa.repository.JpaRepository

interface CommentRepository : JpaRepository<Comment, Long> {
    fun findByConvictedId(convictedId: Long): MutableList<Comment>
}