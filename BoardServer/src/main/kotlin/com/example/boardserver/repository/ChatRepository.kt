package com.example.boardserver.repository

import com.example.boardserver.entity.Chat
import com.example.boardserver.entity.Message
import jakarta.transaction.Transactional
import org.springframework.data.domain.Sort
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface ChatRepository : JpaRepository<Chat, UUID> {
    fun findByOwnerId(id: UUID, sort: Sort): MutableList<Chat>
    fun findByAdId(id: UUID): MutableList<Chat>

    @Modifying
    @Transactional
    override fun deleteById(id: UUID)

    @Transactional
    @Modifying
    @Query("update chat c set c.lastMessage = ?1 where c.id = ?2")
    fun updateLastMessageById(lastMessage: Message?, id: UUID)

    @Query("select c from chat c inner join c.members members where members.id = ?1 and c.isPrivate = true")
    fun findByMembersId(id: UUID): MutableSet<Chat>?

    fun existsByOwnerIdAndReceiverIdAndAdId(
        ownerId: UUID,
        receiverId: UUID,
        adId: UUID
    ): Boolean

    fun findAllByOwnerIdOrReceiverId(
        ownerId: UUID,
        receiverId: UUID,
    ): MutableList<Chat>

    fun findByOwnerIdAndReceiverIdAndAdId(
        ownerId: UUID,
        receiverId: UUID,
        adId: UUID
    ): Optional<Chat>
}

private fun ChatRepository.findChatBetweenUsersByIds(id1: UUID, id2: UUID, idAd: UUID): Optional<Chat>? {
    val intersection: MutableSet<Chat> = this.findByMembersId(id1) ?: mutableSetOf()
    val other: MutableSet<Chat> = this.findByMembersId(id2) ?: mutableSetOf()
    intersection.retainAll(other)
    return intersection.stream().findAny()
}