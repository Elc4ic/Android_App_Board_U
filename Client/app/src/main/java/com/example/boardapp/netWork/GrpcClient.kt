package com.example.boardapp.netWork

import io.grpc.ManagedChannelBuilder
import service.AdServiceGrpcKt
import service.Board
import service.Board.Ad
import service.Board.User
import service.CategoryServiceGrpcKt
import service.ChatServiceGrpcKt
import service.UserServiceGrpcKt


class GrpcClient {
    //"192.168.0.11" ipconfig
    private val port = 9090
    private val channel =
        ManagedChannelBuilder.forAddress("10.193.128.225", port).usePlaintext().build()
    private val adStub = AdServiceGrpcKt.AdServiceCoroutineStub(channel)
    private val userStub = UserServiceGrpcKt.UserServiceCoroutineStub(channel)
    private val categoryStub = CategoryServiceGrpcKt.CategoryServiceCoroutineStub(channel)
    private val chatStub = ChatServiceGrpcKt.ChatServiceCoroutineStub(channel)


    //UserClient
    suspend fun createUser(username: String, password: String) {
        val request = User.newBuilder()
            .setUsername(username)
            .setPassword(password)
            .build()
        userStub.createUser(request)
    }

    suspend fun getUser(id: Long): User {
        val request = Board.Id.newBuilder().setId(id).build()
        return userStub.getUser(request)
    }

    suspend fun getAllUser(): Board.ListUser {
        val request = Board.Empty.newBuilder().build()
        return userStub.getAllUser(request)
    }

    suspend fun updateUser(
        id: Long,
        username: String,
        password: String
    ) {
        val request = User.newBuilder()
            .setId(id)
            .setUsername(username)
            .setPassword(password)
            .build()
        userStub.updateUser(request)
    }

    suspend fun deleteUser(id: Long) {
        val request = Board.Id.newBuilder().setId(id).build()
        userStub.deleteUser(request)
    }


    //AdClient
    suspend fun createAd(
        title: String,
        file: Int,
        price: Int,
        description: String,
        category: Long,
        ownUser: Long
    ) {
        val request = Ad.newBuilder()
            .setTitle(title)
            .setFile(file)
            .setPrice(price)
            .setDescription(description)
            .setCategory(category)
            .setOwnUser(ownUser)
            .build()
        adStub.createAd(request)
    }

    suspend fun getAd(id: Long): Ad {
        val request = Board.Id.newBuilder().setId(id).build()
        return adStub.getAd(request)
    }

    suspend fun getAllAd(): Board.ListAd {
        val request = Board.Empty.newBuilder().build()
        return adStub.getAllAd(request)
    }

    suspend fun updateAd(
        id: Long,
        title: String,
        file: Int,
        price: Int,
        description: String,
        category: Long,
        ownUser: Long
    ) {
        val request = Ad.newBuilder()
            .setId(id)
            .setTitle(title)
            .setFile(file)
            .setPrice(price)
            .setDescription(description)
            .setCategory(category)
            .setOwnUser(ownUser)
            .build()
        adStub.updateAd(request)
    }

    suspend fun deleteAd(id: Long) {
        val request = Board.Id.newBuilder().setId(id).build()
        adStub.deleteAd(request)
    }

    //Category
    suspend fun getAllCategory(): Board.ListCategory {
        val request = Board.Empty.newBuilder().build()
        return categoryStub.getAllCategory(request)
    }

    //Chat
    suspend fun getAllChat(): Board.ListChat {
        val request = Board.Empty.newBuilder().build()
        return chatStub.getAllChat(request)
    }

    suspend fun getChat(id: Long): Board.Chat {
        val request = Board.Id.newBuilder().setId(id).build()
        return chatStub.getChat(request)
    }
    suspend fun getAllMessage(chat: Board.Chat): Board.ListMessage{
        return chatStub.getAllMessage(chat)
    }


}