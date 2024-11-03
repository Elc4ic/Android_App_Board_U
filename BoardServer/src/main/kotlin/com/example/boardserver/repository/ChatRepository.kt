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
    fun findByOwnerId(id: UUID, sort: Sort): MutableSet<Chat>
    fun findByAdId(id: UUID): MutableSet<Chat>?

    @Modifying
    @Transactional
    override fun deleteById(id: UUID)

    @Transactional
    @Modifying
    @Query("update chat c set c.lastMessage = ?1 where c.id = ?2")
    fun updateLastMessageById(lastMessage: Message?, id: UUID)

    @Query("select c from chat c inner join c.members members where members.id = ?1")
    fun findByMembersId(id: UUID): MutableSet<Chat>?

}

fun ChatRepository.findChatBetweenUsersByIds(id1: UUID, id2: UUID, idAd: UUID): Optional<Chat> {
    val intersection: MutableSet<Chat> = this.findByMembersId(id1) ?: mutableSetOf()
    val otherByUser: MutableSet<Chat> = this.findByMembersId(id2) ?: mutableSetOf()
    val otherByAb: MutableSet<Chat> = this.findByAdId(idAd) ?: mutableSetOf()
    intersection.retainAll(otherByUser)
    intersection.retainAll(otherByAb)
    return intersection.stream().findAny()
}