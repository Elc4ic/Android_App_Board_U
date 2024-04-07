package com.example.boardapp.data.database

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.example.boardapp.data.database.converters.ListConverters
import com.example.boardapp.domain.entities.Ad

@Database(entities = [Ad::class, RemoteKeys::class], version = 1)
@TypeConverters(ListConverters::class)
abstract class Database : RoomDatabase() {
    abstract fun AdDao(): AdDao

    abstract fun remoteKeysDao(): RemoteKeysDao
}