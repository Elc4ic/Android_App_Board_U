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

    //TTL config for 8 minutes
    @CachePut(value = ["users"], key = "#id")
    fun saveUser(id: UUID, user: User): User {
        log.info("Save value to cache: $id")
        return user
    }

    @Cacheable(value = ["users"], key = "#id")
    fun getUser(id: UUID): User {
        return User()
    }

    @CacheEvict(value = ["users"], key = "#id")
    fun evictUser(id: UUID) {
        log.info("Evicting value from cache: $id")
    }

    companion object {
        private val log = LoggerFactory.getLogger(CacheService::class.java)
    }
}