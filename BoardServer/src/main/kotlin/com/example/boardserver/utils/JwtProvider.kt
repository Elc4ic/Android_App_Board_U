package com.example.boardserver.utils

import io.jsonwebtoken.*
import io.jsonwebtoken.io.Decoders
import io.jsonwebtoken.security.Keys
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Component
import java.time.LocalDateTime
import java.time.ZoneId
import java.util.*
import java.util.concurrent.TimeUnit
import javax.crypto.SecretKey


@Component
class JwtProvider(
    @Value("\${jwt.secret.access}") jwtAccessSecret: String?,
    @Value("\${jwt.secret.refresh}") jwtRefreshSecret: String?
) {
    private val jwtAccessSecret: SecretKey
    private val jwtRefreshSecret: SecretKey

    init {
        this.jwtAccessSecret = Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtAccessSecret))
        this.jwtRefreshSecret = Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtRefreshSecret))
    }

    fun createJwt(userId: Long): String {
        return Jwts.builder()
            .subject(userId.toString())
            .expiration(Date(System.currentTimeMillis() + TimeUnit.DAYS.toMillis(365)))
            .signWith(jwtAccessSecret)
            .compact()
    }

    fun generateAccessToken(username: String): String {
        val accessExpirationInstant = LocalDateTime.now().plusMinutes(5).atZone(ZoneId.systemDefault()).toInstant()
        val accessExpiration = Date.from(accessExpirationInstant)
        return Jwts.builder()
            .subject(username)
            .expiration(accessExpiration)
            .signWith(jwtAccessSecret)
            .claim("role", "USER")
            .compact()
    }

    fun generateRefreshToken(username: String): String {
        val now = LocalDateTime.now()
        val refreshExpirationInstant = now.plusDays(30).atZone(ZoneId.systemDefault()).toInstant()
        val refreshExpiration = Date.from(refreshExpirationInstant)
        return Jwts.builder()
            .subject(username)
            .expiration(refreshExpiration)
            .signWith(jwtRefreshSecret)
            .compact()
    }

    fun validateAccessToken(accessToken: String): Boolean {
        return validateToken(accessToken)
    }

    fun validateRefreshToken(refreshToken: String): Boolean {
        return validateToken(refreshToken)
    }

    fun validateToken(token: String): Boolean {
        return try {
            Jwts.parser()
                .decryptWith(jwtAccessSecret)
                .build()
                .parseSignedClaims(token)
            return true
        } catch (_: Exception) {
            false
        }
    }

    fun validateJwt(token: String): Long? {
        return try {
            val userId = Jwts.parser()
                .decryptWith(jwtAccessSecret)
                .build()
                .parseSignedClaims(token).payload["userId"]
            userId as Long
        } catch (_: Exception) {
            null
        }
    }
}