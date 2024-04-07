package com.example.boardapp.data.yandex

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import retrofit2.http.Headers
import retrofit2.http.POST
import retrofit2.http.Query

interface YandexLogin {
    companion object {
        const val BASE_URL = "https://oauth.yandex.ru/"
        const val CONTENT_TYPE = "application/json"
    }

    @Serializable
    data class OAuthToken(
        @SerialName("access_token") val accessToken: String,
        @SerialName("token_type") val tokenType: String,
        val scope: String,
    )

    @Headers("Accept: application/json")
    @POST("/token HTTP/1.1")
    suspend fun accessToken(
        @Query("client_id") clientId: String,
        @Query("client_secret") clientSecret: String,
        @Query("code") code: String,
    ): OAuthToken
}