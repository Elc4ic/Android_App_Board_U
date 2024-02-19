package com.example.boardapp.netWork

import androidx.compose.runtime.toMutableStateList
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import service.Board.Ad
import service.Board.Category
import service.Board.Chat
import service.Board.Message

class GrpcViewModel : ViewModel() {

    private var _ads: List<Ad> = emptyList<Ad>().toMutableStateList()
    private var _chats: List<Chat> = emptyList<Chat>().toMutableStateList()
    private var _messages: List<Message> = emptyList<Message>().toMutableStateList()
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

    //Chat
    suspend fun getAllChat() {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                _chats = client.getAllChat().chatsList
            }
        }
    }

    suspend fun getChat(id: Long): Chat {
        var chat = Chat.newBuilder().build()
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                chat = client.getChat(id)
            }
        }
        return chat
    }

    suspend fun getAllMessage(chat: Chat) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                _messages = client.getAllMessage(chat).messagesList
            }
        }
    }

    //getters
    val ads: List<Ad> get() = _ads

    val chats: List<Chat> get() = _chats

    val message: List<Message> get() = _messages

    val categories: List<Category> get() = _categories

}