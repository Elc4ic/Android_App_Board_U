package com.example.boardapp.screens

import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.components.TopBar
import com.example.boardapp.components.card.AdCard
import com.example.boardapp.netWork.GrpcViewModel

@Composable
fun Home(
    navController: NavHostController,
    darkTheme: Boolean,
    toggleTheme: () -> Unit,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    LazyColumn(Modifier.fillMaxSize()) {
            val ads = grpcViewModel.ads
            item {
                TopBar(
                    darkTheme = darkTheme,
                    onToggle = toggleTheme
                )
                Spacer(modifier = Modifier.height(8.dp))
            }
            items(ads) {
                ads.forEach {
                    AdCard(
                        it,
                        onItemClicked = { ad ->
                            navController.navigate("details/${ad.id}/${ad.title}")
                        }
                    )
                }
            }
    }
}