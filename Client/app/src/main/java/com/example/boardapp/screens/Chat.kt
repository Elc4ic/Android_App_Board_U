package com.example.boardapp.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowLeft
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.R
import com.example.boardapp.components.card.MessageCard
import com.example.boardapp.netWork.GrpcViewModel
import kotlinx.coroutines.runBlocking
import service.Board

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Chat(
    navController: NavHostController,
    id: Long,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    var chat = Board.Chat.newBuilder().build()
    runBlocking { chat = grpcViewModel.getChat(id) }
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(chat.usernameOther) },
                colors = TopAppBarDefaults.mediumTopAppBarColors(
                    containerColor = MaterialTheme.colorScheme.background,
                    titleContentColor = colorResource(id = R.color.text)
                ),
                navigationIcon = {
                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.KeyboardArrowLeft,
                        contentDescription = null,
                        modifier = Modifier
                            .size(24.dp)
                            .clickable {
                                navController.navigateUp()
                            },
                        tint = colorResource(id = R.color.text)
                    )
                }
            )
        },

        content = { padding ->
            ChatView(chat, padding)
        }
    )
}

@Composable
fun ChatView(
    chat: Board.Chat,
    padding: PaddingValues,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    LazyColumn(
        modifier = Modifier
            .padding(padding)
            .fillMaxSize()
            .background(color = colorResource(id = R.color.background))
    ) {
        runBlocking {
            grpcViewModel.getAllMessage(chat)
        }
        val message = grpcViewModel.message
        items(message) {
            MessageCard(it)
        }
        item {
            Spacer(modifier = Modifier.height(36.dp))
            Button(
                onClick = { /* Do something! */ },
                modifier = Modifier
                    .fillMaxWidth()
                    .height(52.dp)
                    .padding(16.dp, 0.dp, 16.dp, 0.dp),
                colors = ButtonDefaults.textButtonColors(
                    containerColor = colorResource(id = R.color.blue),
                    contentColor = Color.White
                )
            ) {
                Text("Buy")
            }
            Spacer(modifier = Modifier.height(24.dp))
        }
    }
}
}