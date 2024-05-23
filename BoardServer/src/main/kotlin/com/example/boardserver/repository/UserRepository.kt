package com.example.boardserver.repository

import com.example.boardserver.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface UserRepository : JpaRepository<User, Long> {
    override fun findById(id: Long): Optional<User>
    fun findByToken(token : String): Optional<User>
    fun findByUsername(username : String): Optional<User>
}