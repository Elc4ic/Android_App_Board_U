package com.example.boardapp.netWork

import Service.AdGrpcService
import Service.AdServiceGrpcKt
import io.grpc.ManagedChannelBuilder


class GrpcClient {

    private val port = 9090
    private val channel = ManagedChannelBuilder.forAddress("192.168.0.11", port).usePlaintext().build()
    private val stub = AdServiceGrpcKt.AdServiceCoroutineStub(channel)

    suspend fun getAd(id:Long):AdGrpcService.Ad {
        val request = AdGrpcService.AdRequest.newBuilder().setId(id).build()
        return stub.getAd(request)
    }
    suspend fun getAllAd():AdGrpcService.Ads {
        val request = AdGrpcService.AllAdRequest.newBuilder().build()
        return stub.getAllAd(request)
    }


}