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
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.paint
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.boardapp.navigation.LandingScreen
import com.example.boardapp.navigation.Screen
import com.example.boardapp.netWork.GrpcViewModel
import com.example.boardapp.ui.theme.MyTheme
import com.example.boardapp.view.Details
import com.example.boardapp.view.Home


class MainActivity : ComponentActivity() {
    @OptIn(ExperimentalAnimationApi::class)
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


/*@Composable
fun MainScreen(toggleTheme: () -> Unit) {
    Surface(color = Color.Blue) {
        var showLandingScreen by rememberSaveable {
            mutableStateOf(true)
        }
        if (showLandingScreen) {
            LandingScreen(onTimeout = {
                showLandingScreen = false;
            })
        } else {
            AdListPage()
        }
    }
}*/

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
            BuildScreen(darkTheme,toggleTheme)
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

    val navController = rememberNavController()
    NavHost(navController, startDestination = Screen.Home.route) {
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
    }
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun login() {
    Column(
        Modifier
            .fillMaxSize()
            .paint(
                painterResource(id = R.drawable.background_page),
                contentScale = ContentScale.FillWidth
            ), horizontalAlignment = Alignment.CenterHorizontally
    ) {
        ConstraintLayout(
            modifier = Modifier.fillMaxSize()
        ) {
            val (topText, culm) = createRefs()
            Text(
                text = "Login Activity",
                color = Color.White,
                modifier = Modifier
                    .padding(top = 16.dp, start = 32.dp)
                    .constrainAs(topText) {
                        linkTo(parent.top, culm.top, bias = 0.6f)
                        linkTo(parent.start, parent.end, bias = 0f)
                    },
                fontSize = 30.sp,
                fontWeight = FontWeight.Bold
            )
            Column(Modifier
                .fillMaxWidth()
                .height(600.dp)
                .constrainAs(culm) {
                    bottom.linkTo(parent.bottom)
                }
                .background(
                    color = Color(android.graphics.Color.parseColor("#e0e0e0")),
                    shape = RoundedCornerShape(topStart = 40.dp, topEnd = 40.dp)
                )
                .padding(32.dp)
            ) {
                Text(
                    text = "Email",
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(top = 10.dp),
                    color = Color.Black
                )
                var text by rememberSaveable { mutableStateOf("") }
                TextField(
                    value = text,
                    onValueChange = { text = it },
                    label = { Text(text = "example@gmail.com") },
                    shape = RoundedCornerShape(10.dp),
                    colors = TextFieldDefaults.outlinedTextFieldColors(
                        focusedBorderColor = Color.Transparent,
                        unfocusedBorderColor = Color.Transparent,
                        textColor = Color(android.graphics.Color.parseColor("#5E5E5E")),
                        unfocusedLabelColor = Color(android.graphics.Color.parseColor("#5E5E5E")),
                        focusedLabelColor = Color.Black,
                        containerColor = Color.White
                    ),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 8.dp)
                        .background(Color.White, CircleShape)
                )

                Text(
                    text = "Password",
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(top = 10.dp),
                    color = Color.Black
                )
                var password by rememberSaveable { mutableStateOf("") }
                TextField(
                    value = password,
                    onValueChange = { password = it },
                    label = { Text(text = "12345678") },
                    shape = RoundedCornerShape(10.dp),
                    colors = TextFieldDefaults.outlinedTextFieldColors(
                        focusedBorderColor = Color.Transparent,
                        unfocusedBorderColor = Color.Transparent,
                        textColor = Color(android.graphics.Color.parseColor("#5E5E5E")),
                        unfocusedLabelColor = Color(android.graphics.Color.parseColor("#5E5E5E")),
                        focusedLabelColor = Color.Black,
                        containerColor = Color.White
                    ),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 8.dp)
                        .background(Color.White, CircleShape)
                )

                Button(
                    onClick = { /*TODO*/ },
                    Modifier
                        .padding(top = 32.dp, bottom = 16.dp)
                        .fillMaxWidth()
                        .height(55.dp),
                    colors = ButtonDefaults.buttonColors(
                        containerColor = Color(android.graphics.Color.parseColor("#fa951a"))
                    ),
                    shape = RoundedCornerShape(10.dp)
                ) {
                    Text(
                        text = "Login",
                        color = Color.White,
                        fontSize = 22.sp,
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        }
    }
}
