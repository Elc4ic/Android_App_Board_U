package com.example.boardapp.presentation.viewmodel

import androidx.datastore.core.DataStore
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import auth.v1alpha1.AuthAPIGrpcKt
import auth.v1alpha1.account
import auth.v1alpha1.getJWTRequest
import com.example.boardapp.data.datastore.Session
import com.example.boardapp.data.datastore.jwt
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import timber.log.Timber
import javax.inject.Inject

@HiltViewModel
class LoginViewModel
@Inject
constructor(
    jwtDataStore: DataStore<Session.Jwt>,
    oauthDataStore: DataStore<Session.OAuth>,
    auth: AuthAPIGrpcKt.AuthAPICoroutineStub
) : ViewModel() {
    init {
        viewModelScope.launch {
            oauthDataStore.data.collect {
                if (it.accessToken == "") return@collect
                try{
                val resp =
                    auth.getJWT(
                        getJWTRequest {
                            account = account {
                                provider = "yandex"
                                type = "oauth"
                                accessToken = it.accessToken
                                providerAccountId = it.userId.toString()
                            }
                        }
                    )
                jwtDataStore.updateData { jwt { this.token = resp.token } }
                } catch (e: Exception) {
                    Timber.e(e)
                    _errorState.value = e.toString()
                    oauthDataStore.updateData { oauth -> oauth.defaultInstanceForType }
                }
            }
        }
    }

    private val _errorState = MutableStateFlow<String?>(null)
    val error: StateFlow<String?>
        get() = _errorState

    fun clearError() {
        _errorState.value = null
    }

    val isOnline: StateFlow<Boolean> =
        jwtDataStore.data
            .map { !it.token.isNullOrEmpty() }
            .catch { e ->
                Timber.e(e)
                _errorState.value = e.toString()
            }
            .stateIn(viewModelScope, SharingStarted.Lazily, false)
}