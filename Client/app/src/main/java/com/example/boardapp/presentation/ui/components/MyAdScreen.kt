package com.example.boardapp.presentation.ui.components


import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.runtime.Composable
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.presentation.viewmodel.AdListViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MyAdScreen(
    navController: NavHostController,
    viewModel: AdListViewModel = viewModel()
) {

}