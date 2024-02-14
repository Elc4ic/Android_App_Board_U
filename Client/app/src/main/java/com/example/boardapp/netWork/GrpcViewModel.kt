package com.example.boardapp.netWork

import Service.AdGrpcService.Ad
import androidx.compose.runtime.toMutableStateList
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class GrpcViewModel : ViewModel() {

    private var _ads: List<Ad> = emptyList<Ad>().toMutableStateList()
    private val client = GrpcClient()

    suspend fun getAd(id: Long){
        viewModelScope.launch {
            withContext(Dispatchers.IO){
                val response = client.getAd(id)
            }
        }
    }

    suspend fun getAllAd(){
        viewModelScope.launch {
            _ads = client.getAllAd().adsList
        }
    }

    val ads: List<Ad>
        get() = _ads

}