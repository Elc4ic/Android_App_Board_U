package com.example.boardserver.repository

import com.example.boardserver.entity.Chat
import com.example.boardserver.entity.Message
import jakarta.transaction.Transactional
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface ChatRepository : JpaRepository<Chat, UUID> {
    fun findByAdId(id: UUID): Optional<MutableSet<Chat>>

    @Modifying
    @Transactional
    override fun deleteById(id: UUID)

    @Transactional
    @Modifying
    @Query("UPDATE Chat c SET c.lastMessage = ?1 WHERE c.id = ?2")
    fun updateLastMessageById(lastMessage: Message?, id: UUID)

    @Query("SELECT c FROM Chat c INNER JOIN c.members m WHERE m.id = ?1")
    fun findByMembersId(id: UUID): Optional<Set<Chat>>

}

fun ChatRepository.findChatBetweenUsersByIds(id1: UUID, id2: UUID, idAd: UUID): Optional<Chat> {
    val intersection = this.findByMembersId(id1).orElse(emptySet()).toMutableSet()
    val otherByUser = this.findByMembersId(id2).orElse(emptySet()).toMutableSet()
    val otherByAb: MutableSet<Chat> = this.findByAdId(idAd).orElse(mutableSetOf())
    intersection.retainAll(otherByUser)
    intersection.retainAll(otherByAb)
    return intersection.stream().findAny()
}