package com.example.boardapp.netWork

import androidx.compose.runtime.toMutableStateList
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import service.Board.Ad
import service.Board.Category

class GrpcViewModel : ViewModel() {


    private var _ads: List<Ad> = emptyList<Ad>().toMutableStateList()
    private var _categories: List<Category> = emptyList<Category>().toMutableStateList()
    private val client = GrpcClient()

    //User
    suspend fun createUser(username: String, password: String) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                client.createUser(username, password)
            }
        }
    }

    suspend fun getUser(id: Long) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                val response = client.getAd(id)
            }
        }
    }

    suspend fun updateUser(id: Long, username: String, password: String) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                client.updateUser(id, username, password)
            }
        }
    }

    suspend fun deleteUser(id: Long) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                client.deleteUser(id)
            }
        }
    }

    //Ad
    suspend fun createAd(
        title: String,
        file: Int,
        price: Int,
        description: String,
        category: Long,
        ownUser: Long
    ) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                client.createAd(title, file, price, description, category, ownUser)
            }
        }
    }

    suspend fun getAd(id: Long) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                val response = client.getAd(id)
            }
        }
    }

    suspend fun getAllAd() {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                _ads = client.getAllAd().adsList
            }
        }
    }

    suspend fun updateAd(
        id: Long,
        title: String,
        file: Int,
        price: Int,
        description: String,
        category: Long,
        ownUser: Long
    ) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                client.updateAd(id, title, file, price, description, category, ownUser)
            }
        }
    }

    suspend fun deleteAd(id: Long) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                client.deleteAd(id)
            }
        }
    }

    //Category
    suspend fun getAllCategory() {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                _categories = client.getAllCategory().categoriesList
            }
        }
    }

    //getters
    val ads: List<Ad> get() = _ads

    val categories: List<Category> get() = _categories

}