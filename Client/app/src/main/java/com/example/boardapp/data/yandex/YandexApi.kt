package com.example.boardapp.data.yandex

import kotlinx.serialization.Serializable
import retrofit2.http.GET
import retrofit2.http.Header
import retrofit2.http.Headers

interface YandexApi {
    companion object {
        const val BASE_URL = "https://login.yandex.ru/"
        const val CONTENT_TYPE = "application/x-www-form-urlencoded"
    }

    @Serializable
    data class User(
        val login: String,
        val id: Long,
    )

    @Headers("X-GitHub-Api-Version: 2022-11-28", "Accept: application/json")
    @GET("user")
    suspend fun user(@Header("Authorization") authorization: String): User
}