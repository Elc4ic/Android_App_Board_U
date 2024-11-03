package com.example.boardserver.repository

import com.example.boardserver.entity.DeviceToken
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
interface TokenRepository : JpaRepository<DeviceToken, UUID> {
    fun findByUserId(id: UUID?): Optional<DeviceToken>

    @Modifying
    @Transactional
    fun deleteByUserId(id: UUID)
}