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

    @Query("SELECT u FROM Chat u LEFT JOIN FETCH u.messages WHERE u.id = ?1")
    fun findChatWithMessage(userId: UUID): Optional<Chat>


    @Modifying
    @Transactional
    override fun deleteById(id: UUID)

    @Transactional
    @Modifying
    @Query("UPDATE Chat c SET c.lastMessage = ?1 WHERE c.id = ?2")
    fun updateLastMessageById(lastMessage: Message?, id: UUID)

    @Query("SELECT c FROM Chat c INNER JOIN c.members m WHERE m.id = ?1")
    fun findByMembersId(id: UUID): Optional<Set<Chat>>

    @Query(
        "SELECT c FROM Chat c " +
                "INNER JOIN c.members m1 " +
                "INNER JOIN c.members m2 " +
                "WHERE (m1.id = ?1 AND m2.id = ?2) " +
                "AND c.ad.id = ?3"
    )
    fun findChatBetweenUsersByIds(id1: UUID?, id2: UUID?, idAd: UUID?): Optional<Chat>

}