package com.example.boardserver.repository

import com.example.boardserver.entity.Prompt
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface PromptRepository : JpaRepository<Prompt, Long> {
    override fun findById(id: Long): Optional<Prompt>
}