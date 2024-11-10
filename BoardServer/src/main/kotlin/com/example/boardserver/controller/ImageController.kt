package com.example.boardserver.controller

import com.example.boardserver.entity.uuidOrNull
import com.example.boardserver.repository.ImageRepository
import com.example.boardserver.repository.UserImageRepository
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.io.FileNotFoundException
import java.io.IOException

@RestController
@RequestMapping("/images")
class ImageController(
    private var imageRepository: ImageRepository,
    private var userImageRepository: UserImageRepository
) {

    @GetMapping("/ad/{id}")
    fun getAdImage(@PathVariable("id") id: String): ResponseEntity<ByteArray?>? {
        val image = try {
            imageRepository.findFirstByAdId(id.uuidOrNull()!!).get().imageBytes
        } catch (e: IOException) {
            ClassLoader.getSystemResourceAsStream("default_avatar.jpg")?.readBytes()
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body<ByteArray?>(image)
    }

    @GetMapping("/{id}")
    fun getImage(@PathVariable("id") id: String): ResponseEntity<ByteArray>? {
        val image = try {
            imageRepository.findById(id.uuidOrNull()!!).get().imageBytes
        } catch (e: IOException) {
            ClassLoader.getSystemResourceAsStream("default_avatar.jpg")?.readBytes()
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image)
    }

    @GetMapping("avatar/{userId}")
    fun getAvatar(@PathVariable("userId") userId: String): ResponseEntity<ByteArray>? {
        val image = try {
            val uuid = userId.uuidOrNull()
            if (uuid != null) {
                val imageBytes = imageRepository.findById(uuid).orElse(null)?.imageBytes
                imageBytes ?: loadDefaultImage()
            } else {
                loadDefaultImage()
            }
        } catch (e: Exception) {
            loadDefaultImage()
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image)
    }

    fun loadDefaultImage(): ByteArray {
        return ClassLoader.getSystemResourceAsStream("default_avatar.jpg")?.readBytes()
            ?: throw FileNotFoundException("Default image not found")
    }
}