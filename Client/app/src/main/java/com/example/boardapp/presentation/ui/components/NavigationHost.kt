package com.example.boardapp.presentation.ui.components

import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.boardapp.presentation.ui.components.common.NavBar
import com.example.boardapp.presentation.viewmodel.AdListViewModel
import com.example.boardapp.presentation.viewmodel.DetailViewModel
import com.example.boardapp.presentation.viewmodel.DetailViewModel.Companion.provideFactory
import com.example.boardapp.presentation.viewmodel.LoginViewModel

@Composable
fun NavigationHost(
    modifier: Modifier = Modifier,
    navController: NavHostController = rememberNavController(),
    detailViewModelFactory: DetailViewModel.AssistedFactory,
) {
    NavHost(
        navController = navController,
        startDestination = NavItem.AdList.route,
        modifier = modifier,
    ) {
        composable(NavItem.Login.route) {
            LoginScreen(navController = navController, viewModel = hiltViewModel<LoginViewModel>())
        }

        composable(NavItem.AdList.route) {
            Scaffold(
                bottomBar = { NavBar(navController) },
                content = { padding ->
                    AdListScreen(
                        modifier = Modifier.padding(padding),
                        navController = navController,
                        viewModel = hiltViewModel<AdListViewModel>()
                    )
                }
            )
        }
        composable(NavItem.Profile.route) {
            Scaffold(
                bottomBar = { NavBar(navController) },
                content = { padding ->
                    AboutScreen(modifier = Modifier.padding(padding))
                }
            )
        }
        composable(
            NavItem.Detail("{id}").route,
            arguments = listOf(navArgument("id") { type = NavType.StringType })
        ) {
            val stationId = it.arguments?.getString("id")!!
            Scaffold(
                bottomBar = { NavBar(navController) },
                content = { padding ->
                    DetailScreen(
                        modifier = Modifier.padding(padding),
                        viewModel = viewModel(factory = detailViewModelFactory.provideFactory(stationId))
                    )
                }
            )
        }
    }
}