package com.example.boardserver.service

import board.UserOuterClass.*
import org.springframework.stereotype.Service
import java.util.*


@Service
interface UserService {
    suspend fun startSignUp(userDto: User): UUID
    suspend fun endSignUp(id: UUID,code:String): Boolean
    suspend fun getLogin(request: LoginRequest): LoginResponse
    suspend fun getUserAndRefresh(): UserAvatarToken
    suspend fun setOffline(): Boolean
    suspend fun getUserById(id: UUID): User
    suspend fun logOut(): Boolean
    suspend fun changeUserData(userDto: User): Boolean
    suspend fun setAvatar(image: ImageProto): Boolean
    suspend fun deleteUser(): Boolean
    suspend fun addComment(commentDto: Comment): Boolean
    suspend fun editComment(commentDto: Comment): Boolean
    suspend fun deleteComment(id: UUID): Boolean
    suspend fun getComments(id: UUID): CommentsResponse
    suspend fun getUserComments(): CommentsResponse
}