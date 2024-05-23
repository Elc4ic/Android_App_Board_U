package com.example.boardserver.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController


@RestController
class AdCotroller{

    @GetMapping("/api")
    fun index() = "hello world"

}