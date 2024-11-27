package com.example.boardserver.service

import board.AdOuterClass
import board.UserOuterClass
import org.springframework.stereotype.Service


@Service
interface AdService {
    suspend fun getManyAd(request: AdOuterClass.GetManyAdRequest): AdOuterClass.PaginatedAd
    suspend fun getOneAd(request: AdOuterClass.GetByIdWithBoolRequest): AdOuterClass.Ad
    suspend fun setFavoriteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess
    suspend fun addAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess
    suspend fun editAd(request: AdOuterClass.ChangeAdRequest): UserOuterClass.IsSuccess
    suspend fun deleteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess
    suspend fun muteAd(request: AdOuterClass.GetByIdRequest): UserOuterClass.IsSuccess
    suspend fun getFavoriteAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse
    suspend fun getMyAds(request: UserOuterClass.Empty): AdOuterClass.RepeatedAdResponse
    suspend fun getByUserId(request: AdOuterClass.GetByIdRequest): AdOuterClass.RepeatedAdResponse

}