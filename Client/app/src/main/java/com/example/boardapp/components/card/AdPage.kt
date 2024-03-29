package com.example.boardapp.components.card

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import service.Board

@Composable
fun AdScreen(
    ad: Board.Ad, onRoomExit: () -> Unit,
    modifier: Modifier = Modifier,
) {
    var typedMessage by rememberSaveable {
        mutableStateOf("")
    }
    val scope = rememberCoroutineScope()
    Surface(modifier = modifier.fillMaxSize()) {
        Column {
            Box(
                modifier = modifier
                    .height(50.dp), contentAlignment = Alignment.Center
            ) {
                Row(
                    modifier,
                    Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Button(onClick = { onRoomExit() }) {
                        Text(text = "Exit")
                    }
                    Text(ad.title)
                }
            }
            Spacer(modifier = modifier.padding(5.dp))
            Box(
                modifier = modifier
                    .weight(1f, true)
            ) {
                Text(text = ad.title)
            }
            Spacer(modifier = modifier.padding(5.dp))
            Box(
                modifier = modifier
                    .height(50.dp), contentAlignment = Alignment.Center
            ) {
                Row(modifier, Arrangement.Absolute.SpaceEvenly)
                {
                    Text(text = ad.price.toString(), fontWeight = FontWeight.Bold, fontSize = 20.sp)
                }
            }
        }
    }
}

/*
@Composable
private fun ChatBubble(chatMessages: List<ChatMessage>, modifier: Modifier = Modifier) {
    LazyColumn(modifier = modifier.padding(15.dp)) {
        items(chatMessages) {
            Box (modifier = modifier
                .padding(10.dp)
                .fillParentMaxWidth()
                .height(30.dp)
                .background(color = MaterialTheme.colorScheme.inversePrimary)
                .border(
                    BorderStroke(width = 0.5.dp, color = MaterialTheme.colorScheme.inversePrimary),
                    shape = CircleShape
                )) {
                Text(text = it.message, modifier.padding(5.dp))
            }
        }
    }
}*/
