package com.example.boardapp.data.repository

import AdProto.v1.AdAPIGrpcKt
import AdProto.v1.getOneAdRequest
import AdProto.v1.setFavoriteOneAdRequest
import androidx.datastore.core.DataStore
import androidx.paging.ExperimentalPagingApi
import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import com.example.boardapp.data.database.Database
import com.example.boardapp.data.datastore.Session
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.domain.entities.fromGrpc
import com.example.boardapp.domain.repositories.AdRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject

class AdRepositoryImpl
@Inject
constructor(
    private val adAPI: AdAPIGrpcKt.AdAPICoroutineStub,
    private val database: Database,
    private val jwtDataStore: DataStore<Session.Jwt>,
) : AdRepository {
    companion object {
        private const val NETWORK_PAGE_SIZE = 50
    }

    @OptIn(ExperimentalPagingApi::class)
    override fun watchPages(search: String): Flow<PagingData<Ad>> {
        val pagingSourceFactory = {
            if (search.isNotEmpty()) {
                database.AdDao().watchAsPagingSource(search)
            } else {
                database.AdDao().watchAsPagingSource()
            }
        }
        return Pager(
            config = PagingConfig(pageSize = NETWORK_PAGE_SIZE, enablePlaceholders = false),
            remoteMediator =
            AdRemoteMediator(
                search = search,
                jwtDataStore = jwtDataStore,
                database = database,
                adAPI = adAPI,
            ),
            pagingSourceFactory = pagingSourceFactory
        )
            .flow
            .flowOn(Dispatchers.Default)
    }

    /** Observe one Ad in the cache or the api. */
    @OptIn(ExperimentalCoroutinesApi::class)
    override fun watchOne(id: String): Flow<Ad> =
        jwtDataStore.data.flatMapLatest { jwt ->
            // Try to insert in database
            val ad =
                adAPI.getOneAd(
                    getOneAdRequest {
                        this.id = id
                        this.token = jwt.token
                    }
                )
            ad.let {
                val entity = fromGrpc(it)
                database.AdDao().insert(entity)
            }

            database.AdDao().watchById(id)
        }

    override suspend fun makeFavoriteOne(id: String, value: Boolean): Ad {
        val jwt = jwtDataStore.data.first()

        adAPI.setFavoriteAd(
            setFavoriteOneAdRequest {
                this.id = id
                this.token = jwt.token
                this.value = value
            }
        )
        val ad =
            adAPI.getOneAd(
                getOneAdRequest {
                    this.id = id
                    this.token = jwt.token
                }
            )
        return ad.let {
            val entity = fromGrpc(it)
            database.AdDao().insert(entity)
            entity
        }
    }
}