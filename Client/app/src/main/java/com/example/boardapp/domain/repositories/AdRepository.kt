package com.example.boardapp.domain.repositories

import androidx.paging.PagingData
import com.example.boardapp.domain.entities.Ad
import kotlinx.coroutines.flow.Flow

interface AdRepository {
    fun watchPages(search: String): Flow<PagingData<Ad>>

    fun watchOne(id: String): Flow<Ad>

    suspend fun makeFavoriteOne(id: String, value: Boolean): Ad

    suspend fun addAd(ad: Ad)
}