package com.example.boardserver.utils

import com.example.boardserver.entity.DeviceToken
import com.example.boardserver.entity.User
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Component
import java.util.*
import javax.crypto.Cipher
import javax.crypto.SecretKey
import javax.crypto.spec.SecretKeySpec


@Component
class FcmProvider(
    @Value("\${firebase.secretKey}") secretKey: String?,
) {
    private final val key: SecretKey

    init {
        val decodedKey = Base64.getDecoder().decode(secretKey)
        this.key = SecretKeySpec(decodedKey, 0, decodedKey.size, "AES")
    }

    fun createTokenEntity(user: User, token: String): DeviceToken {
        return DeviceToken(
            id = UUID.randomUUID(),
            user = user,
            deviceToken = encrypt(token)
        )
    }

    fun encrypt(input: String): String {
        val cipher = Cipher.getInstance("AES")
        cipher.init(Cipher.ENCRYPT_MODE, key)
        val encryptedBytes = cipher.doFinal(input.toByteArray())
        return Base64.getEncoder().encodeToString(encryptedBytes)
    }

    fun decrypt(encrypted: String): String {
        val cipher = Cipher.getInstance("AES")
        cipher.init(Cipher.DECRYPT_MODE, key)
        val decodedBytes = Base64.getDecoder().decode(encrypted)
        val decryptedBytes = cipher.doFinal(decodedBytes)
        return String(decryptedBytes)
    }
}