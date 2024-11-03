package com.example.boardserver.repository

import com.example.boardserver.entity.Message
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
interface MessageRepository : JpaRepository<Message, UUID> {
    fun findByChatId(id: UUID): MutableList<Message>

    @Modifying
    @Transactional
    fun deleteAllByChatId(id: UUID)
}