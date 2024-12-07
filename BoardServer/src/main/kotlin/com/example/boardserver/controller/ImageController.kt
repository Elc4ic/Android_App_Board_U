package com.example.boardserver.controller

import com.example.boardserver.entity.uuidOrNull
import com.example.boardserver.repository.ImageRepository
import com.example.boardserver.repository.UserImageRepository
import org.springframework.core.io.ResourceLoader
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.util.FileCopyUtils
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/images")
class ImageController(
    private val imageRepository: ImageRepository,
    private val resourceLoader: ResourceLoader,
    private val userImageRepository: UserImageRepository
) {

    private val defaultImage =
        FileCopyUtils.copyToByteArray(resourceLoader.getResource("classpath:/default_avatar.jpg").inputStream)

    @GetMapping("/ad/{id}")
    fun getAdImage(@PathVariable("id") id: String): ResponseEntity<ByteArray?>? {
        val image = try {
            imageRepository.findFirstByAdId(id.uuidOrNull()!!).get().imageBytes
        } catch (e: Exception) {
            defaultImage
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body<ByteArray?>(image)
    }

    @GetMapping("/{id}")
    fun getImage(@PathVariable("id") id: String): ResponseEntity<ByteArray>? {
        val image = try {
            imageRepository.findById(id.uuidOrNull()!!).get().imageBytes
        } catch (e: Exception) {
            defaultImage
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image)
    }

    @GetMapping("avatar/{userId}")
    fun getAvatar(@PathVariable("userId") userId: String): ResponseEntity<ByteArray>? {
        val image = try {
            val uuid = userId.uuidOrNull()
            if (uuid == null) defaultImage
            else {
                val imageBytes = userImageRepository.findFirstByUserId(uuid).orElse(null)?.imageBytes
                imageBytes ?: defaultImage
            }
        } catch (e: Exception) {
            defaultImage
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image)
    }
}