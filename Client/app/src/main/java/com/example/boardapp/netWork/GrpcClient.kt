package com.example.boardapp.netWork

import io.grpc.ManagedChannelBuilder
import service.AdServiceGrpcKt
import service.Board
import service.Board.User
import service.UserServiceGrpcKt


class GrpcClient {

    private val port = 9090
    private val channel = ManagedChannelBuilder.forAddress("192.168.0.11", port).usePlaintext().build()
    private val adStub = AdServiceGrpcKt.AdServiceCoroutineStub(channel)
    private val userStub = UserServiceGrpcKt.UserServiceCoroutineStub(channel)


    //UserClient
    suspend fun createUser(username:String, password:String){
        val request = User.newBuilder()
            .setUsername(username)
            .setPassword(password)
            .build()
        userStub.createUser(request)
    }

    //AdClient
    suspend fun getAd(id:Long):Board.Ad {
        val request = Board.Id.newBuilder().setId(id).build()
        return adStub.getAd(request)
    }
    suspend fun getAllAd():Board.ListAd {
        val request = Board.Empty.newBuilder().build()
        return adStub.getAllAd(request)
    }


}