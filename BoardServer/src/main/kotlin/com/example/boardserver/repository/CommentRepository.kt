package com.example.boardserver.repository

import com.example.boardserver.entity.Comment
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.transaction.annotation.Transactional
import java.util.*

interface CommentRepository : JpaRepository<Comment, UUID> {
    fun findByConvictedId(convictedId: UUID): MutableList<Comment>
    fun findByCreatorId(ownerId: UUID): MutableList<Comment>

    @Modifying
    @Transactional
    fun deleteByCreatorId(ownerId: UUID)
}