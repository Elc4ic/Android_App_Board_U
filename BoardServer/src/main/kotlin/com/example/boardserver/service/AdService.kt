package com.example.boardserver.service

import board.AdOuterClass.*
import board.UserOuterClass
import org.springframework.stereotype.Service
import java.util.*


@Service
interface AdService {
    suspend fun getManyAd(request: GetManyAdRequest): PaginatedAd
    suspend fun getOneAd(id: UUID, viewed: Boolean): Ad
    suspend fun setFavoriteAd(id: UUID): Boolean
    suspend fun addAd(adGrpc: Ad, images: List<UserOuterClass.ImageProto>): Boolean
    suspend fun editAd(adGrpc: Ad, images: List<UserOuterClass.ImageProto>): Boolean
    suspend fun deleteAd(id: UUID): Boolean
    suspend fun muteAd(id: UUID): Boolean
    suspend fun getFavoriteAds(): RepeatedAdResponse
    suspend fun getMyAds(): RepeatedAdResponse
    suspend fun getByUserId(id: UUID): RepeatedAdResponse

}