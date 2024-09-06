package com.example.boardserver.repository

import com.example.boardserver.entity.DeviceToken
import org.springframework.data.jpa.repository.JpaRepository

interface TokenRepository : JpaRepository<DeviceToken, Long> {
    fun findByUserId(id: Long): DeviceToken
    fun deleteByUserId(id: Long)
}