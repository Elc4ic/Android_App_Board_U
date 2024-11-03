package com.example.boardserver.repository

import com.example.boardserver.entity.Chat
import com.example.boardserver.entity.ChatUserKey
import com.example.boardserver.entity.UnreadCounter
import com.example.boardserver.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.transaction.annotation.Transactional


interface UnreadCounterRepository : JpaRepository<UnreadCounter?, ChatUserKey?> {
    @Transactional
    @Modifying
    @Query("update UnreadCounter u set u.count = u.count + 1 where u.chat = ?1 and u.user = ?2")
    fun incrementCountByChatAndUser(chat: Chat?, user: User?)

    @Transactional
    @Modifying
    @Query("update UnreadCounter u set u.count = 0 where u.chat = ?1 and u.user = ?2")
    fun setCountToZeroByChatAndUser(chat: Chat?, user: User?)
}