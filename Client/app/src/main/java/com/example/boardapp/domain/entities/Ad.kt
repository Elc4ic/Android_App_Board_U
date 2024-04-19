package com.example.boardapp.domain.entities

import adProto.v1.AdOuterClass
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "ads")
data class Ad(
    @PrimaryKey val id: String = "",
    @ColumnInfo(name = "is_favorite") val isFavorite: Boolean = false,
    val title: String = "",
    val description: String = "",
    val price: Long = 0

)

fun fromGrpc(model: AdOuterClass.Ad) =
    Ad(
        model.id.toString(),
        model.isFavorite,
        model.title,
        model.description,
        model.price,
    )


/*    fun asGrpcModel(): AdOuterClass.Ad =
        AdOuterClass.Ad.newBuilder()
            .setId(id)
            .setIsFavorite(isFavorite)
            .setTitle(title)
            .setDescription(description)
            .setPrice(price!!)
            .build()*/
