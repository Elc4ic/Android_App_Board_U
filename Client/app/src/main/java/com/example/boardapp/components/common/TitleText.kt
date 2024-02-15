package com.example.boardapp.components.common

import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp

@Composable
fun TitleText(
    text:String,
    modifier: Modifier) {
    Text(
        text = text,
        modifier = modifier
            .fillMaxWidth(),
        style = TextStyle(
            fontSize = 34.sp,
            fontStyle = FontStyle.Normal,
            fontWeight = FontWeight.Bold),
        color = MaterialTheme.colorScheme.onSurface
    )
}