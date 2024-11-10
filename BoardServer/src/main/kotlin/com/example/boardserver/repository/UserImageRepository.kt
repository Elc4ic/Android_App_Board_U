package com.example.boardserver.repository

import com.example.boardserver.entity.UserImage
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface UserImageRepository : JpaRepository<UserImage, UUID> {
    fun findFirstByUserId(id: UUID?): Optional<UserImage>
}