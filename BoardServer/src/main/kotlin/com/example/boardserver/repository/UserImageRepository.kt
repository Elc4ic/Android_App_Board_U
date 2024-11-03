package com.example.boardserver.repository

import com.example.boardserver.entity.Image
import com.example.boardserver.entity.UserImage
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
interface UserImageRepository : JpaRepository<UserImage, UUID> {

    @Modifying
    @Transactional
    fun deleteAllByUserId(id: UUID)

    fun findFirstByUserId(id: UUID): Optional<Image>

    @Query("SELECT e.id FROM UserImage e WHERE e.user.id = ?1")
    fun findAllIdsByAdId(id: UUID): MutableList<UUID>
}