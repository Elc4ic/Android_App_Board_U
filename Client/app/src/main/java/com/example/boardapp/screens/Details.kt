package com.example.boardapp.screens

import android.annotation.SuppressLint
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavController
import com.example.boardapp.R
import com.example.boardapp.components.card.CategoryCard
import com.example.boardapp.components.card.InfoCard
import com.example.boardapp.netWork.GrpcViewModel

@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Details(
    navController: NavController, id: Int,
) {

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Details") },
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

        content = {
            DetailsView(id)
        }
    )
}

@Composable
fun DetailsView(
    id: Int,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .background(color = colorResource(id = R.color.background))
    ) {
        val ad = grpcViewModel.ads[id]
/*            item {
                ad.apply {

                    val adFile: Painter = painterResource(id = ad.file)
                    Image(
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(346.dp),
                        painter = adFile,
                        alignment = Alignment.CenterStart,
                        contentDescription = "",
                        contentScale = ContentScale.Crop
                    )

                    Spacer(modifier = Modifier.height(16.dp))
                    AdInfoCard(title, price)
                }
            }*/

        // My story details
        item {
            ad.apply {

                Spacer(modifier = Modifier.height(24.dp))
                Title(title = "Description")
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    text = description,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp, 0.dp, 16.dp, 0.dp),
                    color = colorResource(id = R.color.text),
                    style = MaterialTheme.typography.bodySmall,
                    textAlign = TextAlign.Start
                )
            }
        }

        // Quick info
        item {
            ad.apply {

                Spacer(modifier = Modifier.height(24.dp))
                Title(title = "Dog info")
                Spacer(modifier = Modifier.height(16.dp))
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp, 0.dp, 16.dp, 0.dp),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    InfoCard(title = "Price", value = price.toString().plus(" P"))
                }
            }
        }

        item {
            ad.apply {

                Spacer(modifier = Modifier.height(24.dp))
                Title(title = "Owner info")
                Spacer(modifier = Modifier.height(16.dp))
                category.apply {
                    CategoryCard(category)
                }
            }
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

@Composable
fun Title(title: String) {
    Text(
        text = title,
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp, 0.dp, 0.dp, 0.dp),
        color = colorResource(id = R.color.text),
        style = MaterialTheme.typography.titleMedium,
        fontWeight = FontWeight.W600,
        textAlign = TextAlign.Start
    )
}