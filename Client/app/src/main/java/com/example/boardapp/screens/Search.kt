package com.example.boardapp.screens

import android.widget.Toast
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.SearchBar
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.netWork.GrpcViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Search(
    navController: NavHostController,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    var text by remember { mutableStateOf("") }
    var active by remember { mutableStateOf(false) }
    var historyItems = remember {
        mutableStateListOf("SemicolonSpace", "Jetpack Compose", "Android")
    }

    val contextForToast = LocalContext.current.applicationContext
    SearchBar(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = if (active) 0.dp else 8.dp),
        query = text,
        onQueryChange = { newQueryString ->
            text = newQueryString
        },
        onSearch = {
            active = false
            Toast.makeText(contextForToast, "Your query string: $text", Toast.LENGTH_SHORT)
                .show()
            historyItems.add(text)
        },
        active = active,
        onActiveChange = { activeChange ->
            active = activeChange
        },
        placeholder = {
            Text(text = "Search")
        },
        leadingIcon = {
            Icon(imageVector = Icons.Filled.Search, contentDescription = null)
        }
    ) {
        historyItems.forEach { historyItem ->
            Row(modifier = Modifier.padding(all = 16.dp)) {
                Icon(
                    modifier = Modifier.padding(end = 12.dp),
                    imageVector = Icons.Filled.DateRange, contentDescription = null
                )
                Text(text = historyItem)
            }
        }
    }
}