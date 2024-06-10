package com.example.boardserver.repository

import com.example.boardserver.entity.Message
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface MessageRepository : JpaRepository<Message, Long> {
    fun findByChatId(id: Long): MutableList<Message>
}