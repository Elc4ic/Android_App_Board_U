package com.example.boardserver.entity

import board.UserOuterClass.ImageProto
import jakarta.persistence.*
import org.hibernate.annotations.JdbcType
import org.hibernate.type.descriptor.jdbc.VarbinaryJdbcType
import java.util.*

@Entity
@Table(name = "images")
class Image(
    @Id val id: UUID? = null,

    @Lob
    @JdbcType(value = VarbinaryJdbcType::class)
    @Column(columnDefinition = "bytea")
    val imageBytes: ByteArray,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad
)

fun ImageProto.fromImageGrpc(ad: Ad): Image {
    return Image(
        ad = ad,
        imageBytes = this.chunk.toByteArray(),
    )
}

fun List<ImageProto>.fromImageGrpcList(ad: Ad): Set<Image> {
    val images = mutableSetOf<Image>()
    this.forEach { images.add(it.fromImageGrpc(ad)) }
    return images
}
