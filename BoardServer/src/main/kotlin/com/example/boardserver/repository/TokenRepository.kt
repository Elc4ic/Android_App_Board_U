package com.example.boardserver.repository

import com.example.boardserver.entity.DeviceToken
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional

@Repository
interface TokenRepository : JpaRepository<DeviceToken, Long> {
    fun findByUserId(id: Long): DeviceToken

    @Modifying
    @Transactional
    fun deleteByUserId(id: Long)
}