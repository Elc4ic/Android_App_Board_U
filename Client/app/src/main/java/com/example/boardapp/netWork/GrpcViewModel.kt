package com.example.boardapp.netWork

import androidx.compose.runtime.toMutableStateList
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import service.Board

class GrpcViewModel : ViewModel() {

    private var _ads: List<Board.Ad> = emptyList<Board.Ad>().toMutableStateList()
    private val client = GrpcClient()

    //User
    suspend fun createUser(username:String, password:String) {
        viewModelScope.launch {
                client.createUser(username, password)
        }
    }
    //Ad
    suspend fun getAd(id: Long) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                val response = client.getAd(id)
            }
        }
    }
    suspend fun getAllAd() {
        viewModelScope.launch {
            _ads = client.getAllAd().adsList
        }
    }

    val ads: List<Board.Ad> get() = _ads

}