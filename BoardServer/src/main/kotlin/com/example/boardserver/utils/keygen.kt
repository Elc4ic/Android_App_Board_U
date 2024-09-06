package com.example.boardserver.utils

import java.util.*
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey


object AESKeyGenerator {
    @Throws(Exception::class)
    @JvmStatic
    fun main(args: Array<String>) {
        val keyGen: KeyGenerator = KeyGenerator.getInstance("AES")
        keyGen.init(256)
        val secretKey: SecretKey = keyGen.generateKey()

        val base64EncodedKey: String = Base64.getEncoder().encodeToString(secretKey.encoded)
        println("Base64 Encoded AES Key: $base64EncodedKey")
    }
}