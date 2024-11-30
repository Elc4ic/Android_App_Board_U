package com.example.boardserver.service

import com.example.boardserver.entity.User
import org.slf4j.LoggerFactory
import org.springframework.cache.annotation.CacheEvict
import org.springframework.cache.annotation.CachePut
import org.springframework.cache.annotation.Cacheable
import org.springframework.stereotype.Service
import java.util.*

@Service
class CacheService {

    //TTL in config for 8 minutes
    @CachePut(value = ["users"], key = "#id")
    fun saveUser(id: UUID, user: User): User {
        return user
    }
    @CachePut(value = ["codes"], key = "#id")
    fun saveCode(id:UUID, code: String): String {
        return code
    }

    @Cacheable(value = ["users"], key = "#id")
    fun getUser(id: UUID): User {
        return User()
    }

    @Cacheable(value = ["codes"], key = "#id")
    fun getCode(id:UUID): String {
        return "expired"
    }

    @CacheEvict(value = ["users"], key = "#id")
    fun evictUser(id: UUID) {
        log.info("Evicting value from cache: $id")
    }

    @CacheEvict(value = ["codes"], key = "#id")
    fun evictCode(id: UUID) {
        log.info("Evicting value from cache: $id")
    }

    companion object {
        private val log = LoggerFactory.getLogger(CacheService::class.java)
    }
}