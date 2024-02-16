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
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.boardapp.components.NavBar
import com.example.boardapp.screens.LandingScreen
import com.example.boardapp.navigationItem.NavItem
import com.example.boardapp.screens.Details
import com.example.boardapp.screens.Home
import com.example.boardapp.screens.Login
import com.example.boardapp.ui.theme.MyTheme


class MainActivity : ComponentActivity() {
    @OptIn(ExperimentalMaterial3Api::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            var currentTheme by rememberSaveable { mutableStateOf(false) }
            val navController = rememberNavController()

            MyTheme(darkTheme = currentTheme) {
                Scaffold(
                    bottomBar = { NavBar(navController) },
                    content = { padding ->
                        Column(
                            modifier = Modifier
                                .padding(padding) // add margin for the navBar
                                .fillMaxSize()
                        ) {
                            MainScreen(
                                darkTheme = currentTheme,
                                toggleTheme = { currentTheme = !currentTheme },
                                navController = navController
                            )
                        }
                    }
                )
            }
        }
    }

    @OptIn(ExperimentalAnimationApi::class)
    @Composable
    private fun MainScreen(
        darkTheme: Boolean,
        toggleTheme: () -> Unit,
        navController: NavHostController
    ) {
        var showLandingScreen by rememberSaveable {
            mutableStateOf(true)
        }
        if (showLandingScreen) {
            LandingScreen(onTimeout = {
                showLandingScreen = false;
            })
        } else {
            BuildScreen(darkTheme, toggleTheme,navController)
        }
    }

    @ExperimentalAnimationApi
    @Composable
    fun BuildScreen(
        darkTheme: Boolean,
        toggleTheme: () -> Unit,
        navController: NavHostController
    ) {
        val logIn by remember { mutableStateOf(NavItem.Login.route) }

        NavHost(navController, startDestination = logIn) {
            composable(
                NavItem.Home.route,
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
                "${NavItem.Details.route}/{id}/{title}",
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
                NavItem.Login.route,
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
}