package com.example.boardapp.presentation.ui.components


import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.TextFieldValue
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.domain.entities.Ad
import com.example.boardapp.presentation.viewmodel.AddAdViewModel

@Composable
fun AddAdScreen(
    modifier: Modifier = Modifier,
    navController: NavHostController,
    viewModel: AddAdViewModel = viewModel()
) {
    var title by remember { mutableStateOf(TextFieldValue("")) }
    var price by remember { mutableStateOf(TextFieldValue("")) }
    var description by remember { mutableStateOf(TextFieldValue("")) }
    Column {
        TextField(
            value = title,
            onValueChange = { newText ->
                title = newText
            }
        )
        TextField(
            value = description,
            onValueChange = { newText ->
                description = newText
            }
        )
        TextField(
            value = price,
            onValueChange = { newText ->
                price = newText
            }
        )
        Spacer(modifier = Modifier.fillMaxSize())
        Button(
            onClick = {
                viewModel.addAd(
                    Ad(
                        title = title.text,
                        description = description.text,
                        price = price.text.toLong()
                    )
                )
            },
        ) {
            Text("Add")
        }
    }

}