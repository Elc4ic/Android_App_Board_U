package com.example.boardserver.controller

import com.example.boardserver.repository.ImageRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.io.IOException

@RestController
@RequestMapping("/images")
class ImageController {

    private var imageRepository: ImageRepository? = null

    @Autowired
    fun ImageController(repository: ImageRepository?) {
        this.imageRepository = repository
    }

    @GetMapping("/ad/{id}")
    fun getAdImage(@PathVariable("id") id: String): ResponseEntity<ByteArray?>? {
        var image = ByteArray(0)
        try {
            image = imageRepository?.findFirstByAdId(id.toLong())?.get()?.imageBytes ?: ByteArray(0)
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body<ByteArray?>(image)
    }

    @GetMapping("/{id}")
    fun getImage(@PathVariable("id") id: String): ResponseEntity<ByteArray>? {
        var image = ByteArray(0)
        try {
            image = imageRepository?.findById(id.toLong())?.get()?.imageBytes ?: ByteArray(0)
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image)
    }
}