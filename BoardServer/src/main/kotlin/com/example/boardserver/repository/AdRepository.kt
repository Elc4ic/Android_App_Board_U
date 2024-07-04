package com.example.boardserver.repository

import com.example.boardserver.entity.Ad
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface AdRepository : JpaRepository<Ad, Long> {
    override fun findAll(pageable: Pageable): Page<Ad>
    fun findAllByIsActive(pageable: Pageable, active: Boolean): Page<Ad>
    override fun findById(id: Long): Optional<Ad>
    fun findByCategoryId(id: Long): MutableList<Ad>
    fun findByUserId(id: Long): MutableList<Ad>

    @Query("SELECT b FROM Ad b WHERE UPPER(title) like CONCAT('%',UPPER(:search),'%') OR UPPER(description) like CONCAT('%',UPPER(:search),'%') AND isActive = true")
    fun findWithSearchAndActive(pageable: Pageable, @Param("search") search: String?): Page<Ad>
}