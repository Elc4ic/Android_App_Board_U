package com.example.boardserver.entity

import board.AdOuterClass
import com.google.protobuf.kotlin.toByteString
import jakarta.persistence.*
import org.hibernate.annotations.JdbcType
import org.hibernate.type.descriptor.jdbc.VarbinaryJdbcType

@Entity
@Table(name = "images")
class Image(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long = 0L,

    @Lob
    @JdbcType(value = VarbinaryJdbcType::class)
    @Column(columnDefinition = "bytea")
    val imageBytes: ByteArray,

    @ManyToOne
    @JoinColumn(name = "ad_id")
    val ad: Ad
)

fun Image.toImageGrpc(): board.Image.ImageProto {
    return board.Image.ImageProto.newBuilder()
        .setChunk(this.imageBytes.toByteString())
        .build()
}

fun board.Image.ImageProto.fromImageGrpc(ad: Ad): Image {
    return Image(
        ad = ad,
        imageBytes = this.chunk.toByteArray(),
    )
}

fun List<Image>.toImageGrpcList(): AdOuterClass.RepeatedImageResponse {
    val imagesGrpc = mutableListOf<board.Image.ImageProto>()
    this.forEach { imagesGrpc.add(it.toImageGrpc()) }
    return AdOuterClass.RepeatedImageResponse.newBuilder().addAllData(imagesGrpc).build()
}

fun List<board.Image.ImageProto>.fromImageGrpcList(ad: Ad): List<Image> {
    val images = mutableListOf<Image>()
    this.forEach { images.add(it.fromImageGrpc(ad)) }
    return images
}
