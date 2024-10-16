package com.example.boardserver.repository

import com.example.boardserver.entity.DeviceToken
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface TokenRepository : JpaRepository<DeviceToken, Long> {
    fun findByUserId(id: Long): DeviceToken
    fun deleteByUserId(id: Long)
}