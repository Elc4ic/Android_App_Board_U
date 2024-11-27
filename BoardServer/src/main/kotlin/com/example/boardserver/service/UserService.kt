package com.example.boardserver.service

import board.UserOuterClass.*
import org.springframework.stereotype.Service


@Service
interface UserService {
    suspend fun startSignUp(request: SignupRequest): User
    suspend fun endSignUp(request: UserId): IsSuccess
    suspend fun getLogin(request: LoginRequest): LoginResponse
    suspend fun getUserAndRefresh(request: Empty): UserAvatarToken
    suspend fun setOffline(request: Empty): IsSuccess
    suspend fun getUserById(request: UserId): User
    suspend fun logOut(request: Empty): IsSuccess
    suspend fun changeUserData(request: User): IsSuccess
    suspend fun setAvatar(request: ImageProto): IsSuccess
    suspend fun deleteUser(request: Empty): IsSuccess
    suspend fun addComment(request: Comment): IsSuccess
    suspend fun editComment(request: Comment): IsSuccess
    suspend fun deleteComment(request: Id): IsSuccess
    suspend fun getComments(request: UserId): CommentsResponse
    suspend fun getUserComments(request: Empty): CommentsResponse
}