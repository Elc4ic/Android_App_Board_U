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
            .header().add("typ", "JWT")
            .and()
            .subject(userId.toString())
            .expiration(Date(System.currentTimeMillis() + TimeUnit.DAYS.toMillis(365)))
            .signWith(jwtAccessSecret)
            /*.claim("role", "USER")*/
            .compact()
    }

    fun needToRefresh(token: String): Boolean {
        val now = LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant()
        val expiration = Jwts.parser()
            .verifyWith(jwtAccessSecret)
            .build()
            .parseSignedClaims(token).payload.expiration.toInstant()
        return now.isAfter(expiration)
    }

    fun validateToken(token: String): Boolean {
        return try {
            Jwts.parser()
                .verifyWith(jwtAccessSecret)
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
                .verifyWith(jwtAccessSecret)
                .build()
                .parseSignedClaims(token).payload["sub"] as String
            userId.toLong()
        } catch (e: Exception) {
            println(e)
            null
        }
    }
}