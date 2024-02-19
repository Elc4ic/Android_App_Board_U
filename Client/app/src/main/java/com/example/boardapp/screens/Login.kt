package com.example.boardapp.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.paint
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.R
import com.example.boardapp.components.common.NormalButton
import com.example.boardapp.components.common.NormalText
import com.example.boardapp.components.common.TitleText
import com.example.boardapp.netWork.GrpcViewModel
import kotlinx.coroutines.runBlocking

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Login(
    navController: NavHostController,
    grpcViewModel: GrpcViewModel = viewModel()
) {
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
            TitleText(
                text = "Login",
                modifier = Modifier
                    .padding(top = 16.dp, start = 32.dp)
                    .constrainAs(topText) {
                        linkTo(parent.top, culm.top, bias = 0.6f)
                        linkTo(parent.start, parent.end, bias = 0f)
                    }
            )
            Column(Modifier
                .fillMaxWidth()
                .height(600.dp)
                .constrainAs(culm) {
                    bottom.linkTo(parent.bottom)
                }
                .background(
                    color = MaterialTheme.colorScheme.background,
                    shape = RoundedCornerShape(topStart = 40.dp, topEnd = 40.dp)
                )
                .padding(32.dp)
            ) {
                NormalText(
                    text = "Email",
                    modifier = Modifier
                )
                var username by rememberSaveable { mutableStateOf("") }
                TextField(
                    value = username,
                    onValueChange = { username = it },
                    label = { NormalText(text = "example@gmail.com", modifier = Modifier) },
                    shape = RoundedCornerShape(10.dp),
                    colors = TextFieldDefaults.textFieldColors(
                        unfocusedLabelColor = MaterialTheme.colorScheme.surface,
                        focusedLabelColor = MaterialTheme.colorScheme.surface,
                        focusedTextColor = MaterialTheme.colorScheme.surface,
                        containerColor = MaterialTheme.colorScheme.onSurface
                    ),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 8.dp)
                        .background(Color.White, CircleShape)
                )
                NormalText(
                    text = "Password",
                    modifier = Modifier
                )
                var password by rememberSaveable { mutableStateOf("") }
                TextField(
                    value = password,
                    onValueChange = { password = it },
                    label = { NormalText(text = "Enter your password", modifier = Modifier) },
                    shape = RoundedCornerShape(10.dp),
                    colors = TextFieldDefaults.textFieldColors(
                        unfocusedLabelColor = MaterialTheme.colorScheme.surface,
                        focusedLabelColor = MaterialTheme.colorScheme.surface,
                        focusedTextColor = MaterialTheme.colorScheme.surface,
                        containerColor = MaterialTheme.colorScheme.onSurface
                    ),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 8.dp)
                        .background(Color.White, CircleShape)
                )
                NormalButton(
                    text = "Login",
                    onClick = {
                        runBlocking {
                            grpcViewModel.createUser(username,password)
                            navController.navigate("home")
                        }

                    },
                    modifier = Modifier)
            }
        }
    }
}