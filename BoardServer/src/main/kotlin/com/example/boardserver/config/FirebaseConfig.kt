package com.example.boardserver.config

import com.google.auth.oauth2.GoogleCredentials
import com.google.firebase.FirebaseOptions
import com.google.firebase.messaging.FirebaseMessaging
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.core.io.ClassPathResource


@Configuration
class FirebaseConfig {
    @Value("\${firebase.serverKey}")
    private val serverKey: String? = null

    @Bean
    fun firebaseMessaging(): FirebaseMessaging? {
        return FirebaseMessaging.getInstance()
    }

    @Bean
    fun firebaseOptions(): FirebaseOptions {
        return FirebaseOptions.builder()
            .setCredentials(GoogleCredentials.fromStream(ClassPathResource("BoardServer/src/main/resources/google/google-services.json").getInputStream()))
            .build()
    }
}