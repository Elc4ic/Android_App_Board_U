package com.example.boardapp.screens

import android.widget.Toast
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
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
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.components.common.NormalButton
import com.example.boardapp.components.common.NormalText
import com.example.boardapp.netWork.GrpcViewModel
import kotlinx.coroutines.runBlocking

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AddAd(
    navController: NavHostController,
    grpcViewModel: GrpcViewModel = viewModel()
) {
    Column(
        Modifier
            .fillMaxWidth()
            .height(600.dp)
            .background(
                color = MaterialTheme.colorScheme.background,
                shape = RoundedCornerShape(topStart = 40.dp, topEnd = 40.dp)
            )
            .padding(32.dp)
    ) {
        NormalText(
            text = "Title",
            modifier = Modifier
        )
        var title by rememberSaveable { mutableStateOf("") }
        TextField(
            value = title,
            onValueChange = { title = it },
            shape = RoundedCornerShape(10.dp),
            colors = TextFieldDefaults.textFieldColors(
                unfocusedLabelColor = MaterialTheme.colorScheme.surface,
                focusedLabelColor = MaterialTheme.colorScheme.surface,
                focusedTextColor = MaterialTheme.colorScheme.surface,
                unfocusedTextColor = MaterialTheme.colorScheme.surface,
                containerColor = MaterialTheme.colorScheme.onSurface
            ),
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 8.dp)
                .background(Color.White, CircleShape)
        )
        NormalText(
            text = "Price",
            modifier = Modifier
        )
        var price by rememberSaveable { mutableStateOf(0) }
        TextField(
            value = if (price == 0) "" else price.toString(),
            onValueChange = { price = it.toInt() },
            shape = RoundedCornerShape(10.dp),
            colors = TextFieldDefaults.textFieldColors(
                unfocusedLabelColor = MaterialTheme.colorScheme.surface,
                focusedLabelColor = MaterialTheme.colorScheme.surface,
                focusedTextColor = MaterialTheme.colorScheme.surface,
                unfocusedTextColor = MaterialTheme.colorScheme.surface,
                containerColor = MaterialTheme.colorScheme.onSurface
            ),
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 8.dp)
                .background(Color.White, CircleShape)
        )
        NormalText(
            text = "Description",
            modifier = Modifier
        )
        var description by rememberSaveable { mutableStateOf("") }
        TextField(
            value = description,
            onValueChange = { description = it },
            shape = RoundedCornerShape(10.dp),
            colors = TextFieldDefaults.textFieldColors(
                unfocusedLabelColor = MaterialTheme.colorScheme.surface,
                focusedLabelColor = MaterialTheme.colorScheme.surface,
                focusedTextColor = MaterialTheme.colorScheme.surface,
                unfocusedTextColor = MaterialTheme.colorScheme.surface,
                containerColor = MaterialTheme.colorScheme.onSurface
            ),
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 8.dp)
                .background(Color.White, CircleShape)
        )
        var category by mutableStateOf(0L)
        var user by mutableStateOf(0L)
        val contextForToast = LocalContext.current.applicationContext

        Spacer(modifier = Modifier.height(30.dp))
        NormalButton(
            text = "Publish",
            onClick = {
                runBlocking {
                    grpcViewModel.createAd(
                        title,
                        0,
                        price,
                        description,
                        category,
                        user
                    )
                    navController.navigate("home")
                    Toast.makeText(contextForToast, "Your advertisement published", Toast.LENGTH_SHORT).show()
                }
            },
            modifier = Modifier
        )
    }
}