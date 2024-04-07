package com.example.boardapp.data.database

import androidx.paging.PagingSource
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.example.boardapp.domain.entities.Ad
import kotlinx.coroutines.flow.Flow

@Dao
interface AdDao {
    @Query("SELECT * FROM ads") fun watch(): Flow<List<Ad>>

    @Query("SELECT * FROM ads WHERE id = :id") fun watchById(id: String): Flow<Ad>

    @Query("SELECT * FROM ads WHERE title LIKE ('%' || :search || '%') ORDER BY title, id")
    fun watchAsPagingSource(search: String): PagingSource<Int, Ad>

    @Query("SELECT * FROM ads ORDER BY title, id")
    fun watchAsPagingSource(): PagingSource<Int, Ad>

    @Insert(onConflict = OnConflictStrategy.REPLACE) suspend fun insert(items: List<Ad>)

    @Insert(onConflict = OnConflictStrategy.REPLACE) suspend fun insert(vararg items: Ad)

    @Query("DELETE FROM ads") suspend fun clear()
}