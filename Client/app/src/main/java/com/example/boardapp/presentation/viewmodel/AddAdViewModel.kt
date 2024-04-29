package com.example.boardapp.presentation.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.domain.repositories.AdRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import timber.log.Timber
import javax.inject.Inject

class AddAdViewModel @Inject constructor(private val repository: AdRepository) : ViewModel() {

    private val _errorState = MutableStateFlow<String?>(null)
    val error: StateFlow<String?>
        get() = _errorState

    fun clearError() {
        _errorState.value = null
    }

    fun addAd(ad: Ad) =
        viewModelScope.launch(Dispatchers.Main) {
            try {
                repository.addAd(ad)
            } catch (e: Throwable) {
                Timber.e(e)
                _errorState.value = e.toString()
            }
        }
}