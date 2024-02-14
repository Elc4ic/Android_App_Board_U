package com.example.boardapp.model

import androidx.compose.runtime.Immutable

@Immutable
data class User (
    val id: Long,
    val username: String,
    val password: String
)