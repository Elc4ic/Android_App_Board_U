package com.example.boardapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.slideInHorizontally
import androidx.compose.animation.slideOutHorizontally
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.boardapp.navigation.LandingScreen
import com.example.boardapp.navigation.Screen
import com.example.boardapp.netWork.GrpcViewModel
import com.example.boardapp.screens.Details
import com.example.boardapp.screens.Home
import com.example.boardapp.screens.Login
import com.example.boardapp.ui.theme.MyTheme


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            var currentTheme by remember { mutableStateOf(false) }
            MyTheme(darkTheme = currentTheme) {
                Surface(color = MaterialTheme.colorScheme.background) {
                    MainScreen(
                        darkTheme = currentTheme,
                        toggleTheme = { currentTheme = !currentTheme }
                    )
                }
            }
        }
    }
}

@OptIn(ExperimentalAnimationApi::class)
@Composable
private fun MainScreen(
    darkTheme: Boolean,
    toggleTheme: () -> Unit,
) {
    Surface(color = MaterialTheme.colorScheme.background) {
        var showLandingScreen by rememberSaveable {
            mutableStateOf(true)
        }
        if (showLandingScreen) {
            LandingScreen(onTimeout = {
                showLandingScreen = false;
            })
        } else {
            BuildScreen(darkTheme, toggleTheme)
        }
    }
}

@ExperimentalAnimationApi
@Composable
fun BuildScreen(
    darkTheme: Boolean,
    toggleTheme: () -> Unit,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    var logIn by remember { mutableStateOf(Screen.Login.route) }
    val navController = rememberNavController()

    NavHost(navController, startDestination = logIn) {
        composable(
            Screen.Home.route,
            exitTransition = {
                slideOutHorizontally(
                    targetOffsetX = { -300 },
                    animationSpec = tween(
                        durationMillis = 300,
                        easing = FastOutSlowInEasing
                    )
                ) + fadeOut(animationSpec = tween(300))
            },
            popEnterTransition = {
                slideInHorizontally(
                    initialOffsetX = { -300 },
                    animationSpec = tween(
                        durationMillis = 300,
                        easing = FastOutSlowInEasing
                    )
                ) + fadeIn(animationSpec = tween(300))
            },
        ) {
            Home(navController, darkTheme, toggleTheme)
        }
        composable(
            "${Screen.Details.route}/{id}/{title}",
            enterTransition = {
                slideInHorizontally(
                    initialOffsetX = { 300 },
                    animationSpec = tween(
                        durationMillis = 300,
                        easing = FastOutSlowInEasing
                    )
                ) + fadeIn(animationSpec = tween(300))
            },
            exitTransition = {
                slideOutHorizontally(
                    targetOffsetX = { 300 },
                    animationSpec = tween(
                        durationMillis = 300,
                        easing = FastOutSlowInEasing
                    )
                ) + fadeOut(animationSpec = tween(300))
            },
            arguments = listOf(navArgument("id") { type = NavType.IntType })
        ) {
            Details(navController, it.arguments?.getInt("id") ?: 0)
        }
        composable(
            Screen.Login.route,
            enterTransition = {
                slideInHorizontally(
                    initialOffsetX = { 300 },
                    animationSpec = tween(
                        durationMillis = 300,
                        easing = FastOutSlowInEasing
                    )
                ) + fadeIn(animationSpec = tween(300))
            },
            exitTransition = {
                slideOutHorizontally(
                    targetOffsetX = { 300 },
                    animationSpec = tween(
                        durationMillis = 300,
                        easing = FastOutSlowInEasing
                    )
                ) + fadeOut(animationSpec = tween(300))
            },
            arguments = listOf(navArgument("id") { type = NavType.IntType })
        ) {
            Login(navController)
        }
    }
}