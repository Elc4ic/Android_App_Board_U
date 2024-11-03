package com.example.boardserver.repository

import com.example.boardserver.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface UserRepository : JpaRepository<User, UUID> {
    override fun findById(id: UUID): Optional<User>
    fun findByUsername(username: String): Optional<User>
    fun countByPhone(phone: String): Int
    fun countByUsername(username: String): Int
}