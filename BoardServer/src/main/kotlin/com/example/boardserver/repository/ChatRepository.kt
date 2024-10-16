package com.example.boardserver.repository

import com.example.boardserver.entity.Chat
import org.springframework.data.domain.Sort
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface ChatRepository : JpaRepository<Chat, Long> {
    fun findByOwnerId(id: Long, sort: Sort): MutableList<Chat>
    fun findByAdId(id: Long): MutableList<Chat>

    fun countByOwnerIdAndReceiverIdAndAdId(
        ownerId: Long,
        receiverId: Long,
        adId: Long
    ): Long

    fun findAllByOwnerIdOrReceiverId(
        ownerId: Long,
        receiverId: Long,
    ): MutableList<Chat>

    fun findByOwnerIdAndReceiverIdAndAdId(
        ownerId: Long,
        receiverId: Long,
        adId: Long
    ): Optional<Chat>
}