package com.example.boardapp.presentation.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.domain.repositories.AdRepository
import dagger.assisted.Assisted
import dagger.assisted.AssistedInject
import kotlinx.coroutines.flow.*
import timber.log.Timber

class DetailViewModel
@AssistedInject
constructor(
    adRepository: AdRepository,
    @Assisted initialAdId: String,
) : ViewModel() {

    val ad: StateFlow<Ad?> =
        adRepository
            .watchOne(initialAdId)
            .catch { e ->
                Timber.e(e)
                _errorState.value = e.toString()
            }
            .stateIn(viewModelScope, SharingStarted.Lazily, null)

    private val _errorState = MutableStateFlow<String?>(null)
    val error: StateFlow<String?>
        get() = _errorState

    fun clearError() {
        _errorState.value = null
    }

    @dagger.assisted.AssistedFactory
    fun interface AssistedFactory {
        fun create(initialAdId: String): DetailViewModel
    }

    companion object {
        fun AssistedFactory.provideFactory(
            initialAdId: String,
        ): ViewModelProvider.Factory =
            object : ViewModelProvider.Factory {
                @Suppress("UNCHECKED_CAST")
                override fun <T : ViewModel> create(modelClass: Class<T>): T {
                    return this@provideFactory.create(initialAdId) as T
                }
            }
    }
}