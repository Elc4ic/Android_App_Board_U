package com.example.boardserver.repository

import com.example.boardserver.entity.Ad
import com.example.boardserver.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface UserRepository : JpaRepository<User, UUID> {

    override fun findById(id: UUID): Optional<User>

    @Query("SELECT u FROM User u LEFT JOIN FETCH u.ads WHERE u.id = ?1")
    fun findUserWithAds(userId: UUID?): Optional<User>

    @Query("SELECT u FROM User u LEFT JOIN FETCH u.avatar WHERE u.id = ?1")
    fun findUserWithAvatar(userId: UUID?): Optional<User>

    @Query("SELECT u FROM User u LEFT JOIN FETCH u.chats WHERE u.id = ?1")
    fun findUserWithChats(userId: UUID?): Optional<User>

    @Query("SELECT u FROM User u LEFT JOIN FETCH u.comments WHERE u.username = ?1")
    fun findByUsernameWithComments(username: String): Optional<User>

    @Query("SELECT u FROM User u LEFT JOIN FETCH u.favs WHERE u.id = ?1")
    fun findUserWithFavs(userId: UUID?): Optional<User>

    @Query("SELECT u.favs FROM User u WHERE u.id = ?1")
    fun findFavsByUserId(userId: UUID?): MutableList<Ad>

    fun existsByPhone(phone: String): Boolean
    fun existsByUsername(username: String): Boolean

}