package com.example.boardapp.data.database.converters

import androidx.room.ProvidedTypeConverter
import androidx.room.TypeConverter
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

@ProvidedTypeConverter
class ListConverters private constructor(private val json: Json) {
    @TypeConverter
    fun fromString(value: String): List<Double> {
        return json.decodeFromString(value)
    }

    @TypeConverter
    fun fromList(list: List<Double>): String {
        return json.encodeToString(list)
    }

    companion object {
        fun create(json: Json): ListConverters {
            return ListConverters(json)
        }
    }
}