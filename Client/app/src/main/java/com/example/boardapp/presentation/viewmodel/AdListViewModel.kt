package com.example.boardapp.presentation.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.PagingData
import androidx.paging.cachedIn
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.domain.repositories.AdRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import timber.log.Timber
import javax.inject.Inject

@HiltViewModel
class AdListViewModel @Inject constructor(private val repository: AdRepository) : ViewModel() {

    private val _search = MutableStateFlow("")
    val search: StateFlow<String>
        get() = _search

    fun updateSearch(s: String) {
        _search.value = s
    }

    @OptIn(ExperimentalCoroutinesApi::class)
    val pages: StateFlow<PagingData<Ad>> =
        search
            .flatMapLatest { s -> repository.watchPages(s).cachedIn(viewModelScope) }
            .catch { e ->
                Timber.e(e)
                _errorState.value = e.toString()
            }
            .stateIn(viewModelScope, SharingStarted.Lazily, PagingData.empty())

    private val _errorState = MutableStateFlow<String?>(null)
    val error: StateFlow<String?>
        get() = _errorState

    fun clearError() {
        _errorState.value = null
    }

    fun makeFavorite(id: String, value: Boolean) =
        viewModelScope.launch(Dispatchers.Main) {
            try {
                repository.makeFavoriteOne(id, value)
            } catch (e: Throwable) {
                Timber.e(e)
                _errorState.value = e.toString()
            }
        }
}