package com.example.boardapp.presentation.ui.components

import android.content.Intent
import android.net.Uri
import android.widget.Toast
import androidx.browser.customtabs.CustomTabsIntent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.ElevatedButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.boardapp.R
import com.example.boardapp.data.yandex.YandexLogin
import com.example.boardapp.presentation.viewmodel.LoginViewModel

@Composable
fun LoginScreen(
    modifier: Modifier = Modifier,
    navController: NavHostController,
    viewModel: LoginViewModel = viewModel()
) {
    val context = LocalContext.current
    val isOnline by viewModel.isOnline.collectAsState()

    LaunchedEffect(isOnline) {
        if (isOnline) {
            navController.navigate(NavItem.Home.route) {
                popUpTo(NavItem.Login.route) { inclusive = true }
            }
        }
    }

    val error by viewModel.error.collectAsState()
    LaunchedEffect(error) {
        if (!error.isNullOrEmpty()) {
            Toast.makeText(context, error, Toast.LENGTH_SHORT).show()
            viewModel.clearError()
        }
    }

    fun login() {
        val uri =
            Uri.parse(YandexLogin.BASE_URL)
                .buildUpon()
                .appendPath("authorize")
                .appendQueryParameter("response_type","code")
                .appendQueryParameter("client_id", context.getString(R.string.yandex_client_id))
/*                .appendQueryParameter("scope", "login:email login:info login:birthday")
                .appendQueryParameter("state", UUID.randomUUID().toString())
                .appendQueryParameter("redirect_uri", "https://train.mnguyen.fr/oauth2")*/
                .build()

        val customTabsIntent = CustomTabsIntent.Builder().build()
        customTabsIntent.intent.apply { addCategory(Intent.CATEGORY_BROWSABLE) }
        customTabsIntent.launchUrl(context, uri)
    }

    Column(
        modifier = modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        ElevatedButton(onClick = { login() }) { Text(stringResource(R.string.sign_in_with_yandex)) }
    }

}