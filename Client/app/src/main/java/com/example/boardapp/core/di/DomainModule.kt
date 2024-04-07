package com.example.boardapp.core.di

import com.example.boardapp.data.repository.AdRepositoryImpl
import com.example.boardapp.domain.repositories.AdRepository
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
interface DomainModule {
    @Binds
    @Singleton
    fun bindStationRepository(repository: AdRepositoryImpl): AdRepository
}