package com.example.boardapp.screens

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.components.card.AdCard
import com.example.boardapp.netWork.GrpcViewModel

@Composable
fun Chats(
    navController: NavHostController,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    LazyColumn(Modifier.fillMaxSize()) {
        val chats = grpcViewModel.chats
        items(chats) {
            chats.forEach {
                AdCard(
                    it,
                    onItemClicked = { chat ->
                        navController.navigate("chat/${chat.id}")
                    }
                )
            }
        }
    }
}