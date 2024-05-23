package com.example.boardserver.utils

import com.example.boardserver.entity.User
import io.jsonwebtoken.*
import io.jsonwebtoken.io.Decoders
import io.jsonwebtoken.security.Keys
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Component
import java.security.SignatureException
import java.time.LocalDateTime
import java.time.ZoneId
import java.util.*
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

    fun generateAccessToken(user: User): String {
        val now = LocalDateTime.now()
        val accessExpirationInstant = now.plusMinutes(5).atZone(ZoneId.systemDefault()).toInstant()
        val accessExpiration = Date.from(accessExpirationInstant)
        return Jwts.builder()
            .subject(user.username)
            .expiration(accessExpiration)
            .signWith(jwtAccessSecret)
            .claim("role", "USER")
            .compact();
    }

    fun generateRefreshToken(user: User): String {
        val now = LocalDateTime.now()
        val refreshExpirationInstant = now.plusDays(30).atZone(ZoneId.systemDefault()).toInstant()
        val refreshExpiration = Date.from(refreshExpirationInstant)
        return Jwts.builder()
            .subject(user.username)
            .expiration(refreshExpiration)
            .signWith(jwtRefreshSecret)
            .compact()
    }

    fun validateAccessToken(accessToken: String): Boolean {
        return validateToken(accessToken, jwtAccessSecret)
    }

    fun validateRefreshToken(refreshToken: String): Boolean {
        return validateToken(refreshToken, jwtRefreshSecret)
    }

    private fun validateToken(token: String, secret: SecretKey): Boolean {
        try {
            Jwts.parser()
                .decryptWith(secret)
                .build()
                .parseSignedClaims(token)
            return true
        } catch (_: ExpiredJwtException) {
        } catch (_: UnsupportedJwtException) {
        } catch (_: MalformedJwtException) {
        } catch (_: SignatureException) {
        } catch (_: Exception) {
        }
        return false
    }

    fun getAccessClaims(token: String): Claims {
        return getClaims(token, jwtAccessSecret)
    }

    fun getRefreshClaims(token: String): Claims {
        return getClaims(token, jwtRefreshSecret)
    }

    private fun getClaims(token: String,secret: SecretKey): Claims {
        return Jwts.parser()
            .decryptWith(secret)
            .build()
            .parseSignedClaims(token)
            .payload
    }
}