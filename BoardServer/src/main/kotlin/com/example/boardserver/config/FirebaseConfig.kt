package com.example.boardserver.config

import com.google.auth.oauth2.GoogleCredentials
import com.google.firebase.FirebaseApp
import com.google.firebase.FirebaseOptions
import com.google.firebase.messaging.FirebaseMessaging
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.core.io.ClassPathResource
import java.io.FileInputStream


@Configuration
class FirebaseConfig {

    @Bean
    fun firebaseMessaging(): FirebaseMessaging? {
        val options = FirebaseOptions.builder()
            .setCredentials(GoogleCredentials.fromStream(ClassPathResource("dvfu-board-firebase-adminsdk-chm4o-a336ff57a6.json").inputStream))
            .build()
        val firebaseApp = FirebaseApp.initializeApp(options)
        return FirebaseMessaging.getInstance(firebaseApp)
    }
}