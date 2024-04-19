package com.example.boardapp.core.di

import adProto.v1.AdAPIGrpcKt
import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.core.DataStoreFactory
import androidx.datastore.dataStoreFile
import androidx.room.Room
import auth.v1alpha1.AuthAPIGrpcKt
import com.example.boardapp.BuildConfig
import com.example.boardapp.data.database.AdDao
import com.example.boardapp.data.database.Database
import com.example.boardapp.data.database.RemoteKeysDao
import com.example.boardapp.data.database.converters.ListConverters
import com.example.boardapp.data.datastore.JwtSerializer
import com.example.boardapp.data.datastore.OAuthSerializer
import com.example.boardapp.data.datastore.Session
import com.example.boardapp.data.yandex.YandexApi
import com.example.boardapp.data.yandex.YandexLogin
import com.jakewharton.retrofit2.converter.kotlinx.serialization.asConverterFactory
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import io.grpc.Grpc
import io.grpc.ManagedChannelBuilder
import io.grpc.TlsChannelCredentials
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.asExecutor
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.json.Json
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DataModule {

    @Provides
    @Singleton
    fun provideAdAPI(): AdAPIGrpcKt.AdAPICoroutineStub {
        return AdAPIGrpcKt.AdAPICoroutineStub(
            ManagedChannelBuilder.forAddress("localhost", 9090)
                .usePlaintext()
                .executor(Dispatchers.IO.asExecutor())
                .build()
        )
    }

    @Provides
    @Singleton
    fun provideAuthAPI(): AuthAPIGrpcKt.AuthAPICoroutineStub {
        return AuthAPIGrpcKt.AuthAPICoroutineStub(
            Grpc.newChannelBuilder("192.168.0.11:9090", TlsChannelCredentials.create())
                .executor(Dispatchers.IO.asExecutor())
                .build()
        )
    }

    @ExperimentalSerializationApi
    @Provides
    @Singleton
    fun provideYandexApi(client: OkHttpClient, json: Json): YandexApi {
        return Retrofit.Builder()
            .baseUrl(YandexApi.BASE_URL)
            .addConverterFactory(json.asConverterFactory(YandexApi.CONTENT_TYPE.toMediaType()))
            .client(client)
            .build()
            .create(YandexApi::class.java)
    }

    @ExperimentalSerializationApi
    @Provides
    @Singleton
    fun provideYandexLogin(client: OkHttpClient, json: Json): YandexLogin {
        return Retrofit.Builder()
            .baseUrl(YandexLogin.BASE_URL)
            .addConverterFactory(json.asConverterFactory(YandexLogin.CONTENT_TYPE.toMediaType()))
            .client(client)
            .build()
            .create(YandexLogin::class.java)
    }

    @Provides
    @Singleton
    fun provideHttpClient(): OkHttpClient {
        return when {
            BuildConfig.DEBUG -> {
                val interceptor =
                    HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY)
                OkHttpClient.Builder().addInterceptor(interceptor).build()
            }

            else -> OkHttpClient()
        }
    }

    @Singleton
    @Provides
    fun provideJson() = Json {
        isLenient = true
        ignoreUnknownKeys = true
    }

    @Singleton
    @Provides
    fun provideRoomDatabase(@ApplicationContext context: Context, json: Json): Database {
        val listConverters = ListConverters.create(json)
        return Room.databaseBuilder(context, Database::class.java, "cache.db")
            .build()
    }

    @Singleton
    @Provides
    fun provideJwtDataStore(@ApplicationContext context: Context): DataStore<Session.Jwt> {
        return DataStoreFactory.create(
            serializer = JwtSerializer,
            scope = CoroutineScope(Dispatchers.IO + SupervisorJob()),
            produceFile = { context.dataStoreFile("jwt.pb") }
        )
    }

    @Singleton
    @Provides
    fun provideOAuthDataStore(@ApplicationContext context: Context): DataStore<Session.OAuth> {
        return DataStoreFactory.create(
            serializer = OAuthSerializer,
            scope = CoroutineScope(Dispatchers.IO + SupervisorJob()),
            produceFile = { context.dataStoreFile("oauth.pb") }
        )
    }

    @Singleton
    @Provides
    fun provideAdDao(database: Database): AdDao {
        return database.AdDao()
    }

    @Singleton
    @Provides
    fun provideRemoteKeysDao(database: Database): RemoteKeysDao {
        return database.remoteKeysDao()
    }
}