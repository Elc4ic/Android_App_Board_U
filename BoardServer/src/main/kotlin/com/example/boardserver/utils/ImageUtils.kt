package com.example.boardserver.utils

import board.Image.ImageProto
import com.example.boardserver.entity.Ad
import com.example.boardserver.entity.Image
import com.google.protobuf.kotlin.toByteString

object ImageUtils {

    fun toImageGrpc(image: Image): ImageProto {
        return ImageProto.newBuilder()
            .setChunk(image.imageBytes.toByteString())
            .build()
    }

    fun fromImageGrpc(image: ImageProto, ad: Ad): Image {
        return Image(
            ad = ad,
            imageBytes = image.chunk.toByteArray(),
        )
    }

    fun toImageGrpcList(images: List<Image>): List<ImageProto> {
        val imagesGrpc = mutableListOf<ImageProto>()
        images.forEach { imagesGrpc.add(toImageGrpc(it)) }
        return imagesGrpc
    }

    fun fromImageGrpcList(imagesGrpc: List<ImageProto>, ad: Ad): List<Image> {
        val images = mutableListOf<Image>()
        imagesGrpc.forEach { images.add(fromImageGrpc(it, ad)) }
        return images
    }

}