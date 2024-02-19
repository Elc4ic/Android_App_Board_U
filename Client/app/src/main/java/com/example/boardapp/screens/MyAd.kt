package com.example.boardapp.screens


import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.components.card.AdCard
import com.example.boardapp.components.common.NormalButton
import com.example.boardapp.netWork.GrpcViewModel
import kotlinx.coroutines.runBlocking
import service.Board.Ad

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MyAd(
    navController: NavHostController,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    Scaffold(
        bottomBar = {
            Row(
                Modifier.padding(8.dp)
            ) {
                NormalButton(
                    text = "Add",
                    onClick = {
                        navController.navigate("addAd")
                              },
                    modifier = Modifier
                )
            }
        },
        content = { padding ->
            LazyColumn(
                        Modifier
                            .padding(padding)
                    ) {
                        val ad1 = Ad.newBuilder().setTitle("STR1").setPrice(1000).build()
                        val ad2 = Ad.newBuilder().setTitle("STR2").setPrice(2000).build()
                        val ad4 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad5 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad6 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad7 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad8 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad9 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad10 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad11 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad12 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ad13 = Ad.newBuilder().setTitle("STR3").setPrice(3000).build()
                        val ads = listOf<Ad>(ad1, ad2, ad4, ad5, ad6, ad7, ad8, ad9, ad10, ad11, ad12)
                        runBlocking {
                            items(ads) {
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
    )
}