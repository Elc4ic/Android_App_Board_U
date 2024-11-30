package com.example.boardserver.service

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import okhttp3.HttpUrl.Companion.toHttpUrlOrNull
import okhttp3.OkHttpClient
import okhttp3.Request
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import java.io.IOException

@Service
class VerifyService(
    @Value("\${zvonok.callKey}") private val callKey: String?,
    @Value("\${zvonok.campainID}") private val campainID: String?,
) {
    private val client = OkHttpClient()
    private val callBaseURL: String = "https://zvonok.com"

    fun makeCall(phone: String): CallResponse? {
        val url = ("$callBaseURL/manager/cabapi_external/api/v1/phones/flashcall/").toHttpUrlOrNull()?.newBuilder()
            ?.addQueryParameter("public_key", callKey)
            ?.addQueryParameter("phone", phone)
            ?.addQueryParameter("campaign_id", campainID)
            ?.build() ?: return null

        val request = Request.Builder().url(url).build()

        client.newCall(request).execute().use { response ->
            if (!response.isSuccessful) throw IOException("Unexpected code $response")
            val callResponse = response.body?.string()?.toCallResponse()
            return callResponse
        }
    }

    fun checkCallStatus(callId: Long): CallCheckResponse? {
        val url = ("$callBaseURL/manager/cabapi_external/api/v1/phones/calls_by_id/").toHttpUrlOrNull()?.newBuilder()
            ?.addQueryParameter("public_key", callKey)
            ?.addQueryParameter("call_id", callId.toString())
            ?.build() ?: return null

        val request = Request.Builder().url(url).build()

        client.newCall(request).execute().use { response ->
            if (!response.isSuccessful) throw IOException("Unexpected code $response")
            val callResponse = response.body?.string()?.toCallCheckResponse()
            return callResponse
        }
    }

    @Serializable
    data class CallResponse(
        val status: String,
        val data: CallData
    )

    @Serializable
    data class CallData(
        val balance: String,
        val call_id: Long,
        val created: String,
        val phone: String,
        val pincode: String
    )

    @Serializable
    data class CallCheckResponse(
        val phone: String,
        val status_display: String,
        val recorded_audio: String,
        val status: String,
        val dial_status_display: String,
        val dial_status: String,
        val call_id: Long,
        val user_choice: String,
        val updated: String,
        val user_choice_display: String,
        val action_type: String,
        val created: String,
        val button_num: Int,
        val completed: String,
        val duration: Int,
        val audioclip_id: Long,
        val ivr_data: String,
        val transcribing: List<Transcribing>,
        val cost: String,
        val currency: String,
        val attempts: List<Attempts>,
    )

    @Serializable
    data class Attempts(
        val created: String,
        val call_type: String,
        val attempt_num: Int,
        val status: String,
        val dial_status: Int,
        val billsec: Int,
        val cost: Double,
        val currency: String,
        val recorded_audio: String
    )

    @Serializable
    data class Transcribing(
        val normal_text: String,
        val channer: String,
        val start_time: Double,
        val end_time: Double
    )

    private fun String.toCallCheckResponse(): CallCheckResponse = Json.decodeFromString<CallCheckResponse>(this)

    private fun String.toCallResponse(): CallResponse = Json.decodeFromString<CallResponse>(this)
}