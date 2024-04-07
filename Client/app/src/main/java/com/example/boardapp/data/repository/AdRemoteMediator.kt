package com.example.boardapp.data.repository

import AdProto.v1.AdAPIGrpcKt
import AdProto.v1.getManyAdRequest
import androidx.datastore.core.DataStore
import androidx.paging.ExperimentalPagingApi
import androidx.paging.LoadType
import androidx.paging.PagingState
import androidx.paging.RemoteMediator
import androidx.room.withTransaction
import com.example.boardapp.data.database.Database
import com.example.boardapp.data.database.RemoteKeys
import com.example.boardapp.data.datastore.Session
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.domain.entities.fromGrpc
import io.grpc.StatusException
import kotlinx.coroutines.flow.first
import java.io.IOException

@OptIn(ExperimentalPagingApi::class)
class AdRemoteMediator(
    private val search: String,
    private val adAPI: AdAPIGrpcKt.AdAPICoroutineStub,
    private val database: Database,
    private val jwtDataStore: DataStore<Session.Jwt>,
) : RemoteMediator<Int, Ad>() {
    companion object {
        private const val STARTING_PAGE_INDEX = 1
    }

    override suspend fun initialize(): InitializeAction {
        return InitializeAction.LAUNCH_INITIAL_REFRESH
    }

    override suspend fun load(
        loadType: LoadType,
        state: PagingState<Int, Ad>
    ): MediatorResult {
        val page =
            when (loadType) {
                LoadType.REFRESH -> {
                    val remoteKeys = getRemoteKeyClosestToCurrentPosition(state)
                    remoteKeys?.nextKey?.minus(1) ?: STARTING_PAGE_INDEX
                }
                LoadType.PREPEND -> {
                    val remoteKeys = getRemoteKeyForFirstItem(state)
                    remoteKeys?.prevKey
                        ?: return MediatorResult.Success(
                            endOfPaginationReached = remoteKeys != null
                        )
                }
                LoadType.APPEND -> {
                    val remoteKeys = getRemoteKeyForLastItem(state)
                    remoteKeys?.nextKey
                        ?: return MediatorResult.Success(
                            endOfPaginationReached = remoteKeys != null
                        )
                }
            }

        return try {
            val jwt = jwtDataStore.data.first()
            val resp =
                adAPI.getManyAd(
                    getManyAdRequest {
                        this.query = search
                        this.page = page.toLong()
                        this.limit = state.config.pageSize.toLong()
                        token = jwt.token
                    }
                )
            val items = resp.dataList
            val endOfPaginationReached = items.isEmpty()
            database.withTransaction {
                // clear all tables in the database
                if (loadType == LoadType.REFRESH) {
                    database.remoteKeysDao().clear()
                    database.AdDao().clear()
                }
                val prevKey = if (page == STARTING_PAGE_INDEX) null else page - 1
                val nextKey = if (endOfPaginationReached) null else page + 1
                val keys =
                    items.map { RemoteKeys(id = it.id, prevKey = prevKey, nextKey = nextKey) }
                database.remoteKeysDao().insert(keys)
                database.AdDao().insert(items.map { fromGrpc(it) })
            }
            MediatorResult.Success(endOfPaginationReached = endOfPaginationReached)
        } catch (exception: IOException) {
            MediatorResult.Error(exception)
        } catch (exception: StatusException) {
            MediatorResult.Error(exception)
        }
    }

    private suspend fun getRemoteKeyClosestToCurrentPosition(
        state: PagingState<Int, Ad>
    ): RemoteKeys? {
        return state.anchorPosition?.let { position ->
            state.closestItemToPosition(position)?.id?.let { id ->
                database.remoteKeysDao().findById(id)
            }
        }
    }

    private suspend fun getRemoteKeyForFirstItem(state: PagingState<Int, Ad>): RemoteKeys? {
        return state.pages
            .firstOrNull { it.data.isNotEmpty() }
            ?.data
            ?.firstOrNull()
            ?.let { item ->
                // Get the remote keys of the first items retrieved
                database.remoteKeysDao().findById(item.id)
            }
    }

    private suspend fun getRemoteKeyForLastItem(state: PagingState<Int, Ad>): RemoteKeys? {
        return state.pages
            .lastOrNull { it.data.isNotEmpty() }
            ?.data
            ?.lastOrNull()
            ?.let { item ->
                // Get the remote keys of the last item retrieved
                database.remoteKeysDao().findById(item.id)
            }
    }
}