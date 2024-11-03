package com.example.boardserver.controller

import com.example.boardserver.entity.uuid
import com.example.boardserver.repository.ImageRepository
import com.example.boardserver.repository.UserImageRepository
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.io.IOException

@RestController
@RequestMapping("/images")
class ImageController(
    private var imageRepository: ImageRepository,
    private var userImageRepository: UserImageRepository
) {

    @GetMapping("/ad/{id}")
    fun getAdImage(@PathVariable("id") id: String): ResponseEntity<ByteArray?>? {
        var image = ByteArray(0)
        try {
            image = imageRepository.findFirstByAdId(id.uuid()).get().imageBytes
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body<ByteArray?>(image)
    }

    @GetMapping("/{id}")
    fun getImage(@PathVariable("id") id: String): ResponseEntity<ByteArray>? {
        var image = ByteArray(0)
        try {
            image = imageRepository.findById(id.uuid()).get().imageBytes
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image)
    }

    @GetMapping("avatar/{userId}")
    fun getAvatar(@PathVariable("userId") userId: String): ResponseEntity<ByteArray>? {
        var image = ByteArray(0)
        try {
            image = userImageRepository.findFirstByUserId(userId.uuid()).orElseThrow().imageBytes
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image)
    }
}