package com.example.boardapp.model

import androidx.compose.runtime.Immutable

@Immutable
data class Category (
    val id: Long,
    val name: String,
)