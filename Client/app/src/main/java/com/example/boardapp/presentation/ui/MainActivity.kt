package com.example.boardapp.presentation.ui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Modifier
import androidx.datastore.core.DataStore
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController
import com.example.boardapp.R
import com.example.boardapp.data.datastore.Session
import com.example.boardapp.data.datastore.oAuth
import com.example.boardapp.data.yandex.YandexApi
import com.example.boardapp.data.yandex.YandexLogin
import com.example.boardapp.presentation.ui.components.NavigationHost
import com.example.boardapp.presentation.ui.theme.MyTheme
import com.example.boardapp.presentation.viewmodel.DetailViewModel
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import java.io.File
import javax.inject.Inject

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    @Inject
    lateinit var assisted: DetailViewModel.AssistedFactory
    @Inject lateinit var yandexLogin: YandexLogin
    @Inject lateinit var oauthDataStore: DataStore<Session.OAuth>
    @Inject lateinit var yandexApi: YandexApi

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        File("/data/data/com.example.boardapp/code_cache/.overlay/base.apk/classes11.dex").setReadOnly()

        /*intent.data?.getQueryParameter("code")?.let { code -> loginOAuth(code) }*/

        setContent {

            var currentTheme by rememberSaveable { mutableStateOf(false) }
            val navController = rememberNavController()

            var canPop by remember { mutableStateOf(false) }

            DisposableEffect(navController) {
                val listener =
                    NavController.OnDestinationChangedListener { controller, _, _ ->
                        canPop = controller.previousBackStackEntry != null
                    }
                navController.addOnDestinationChangedListener(listener)
                onDispose { navController.removeOnDestinationChangedListener(listener) }
            }

            MyTheme(darkTheme = currentTheme) {
                NavigationHost(
                    navController = navController,
                    detailViewModelFactory = assisted,
                    modifier = Modifier
                )
            }
        }
    }

    private fun loginOAuth(code: String) {
        lifecycleScope.launch {
            val token =
                yandexLogin.accessToken(
                    getString(R.string.yandex_client_id),
                    getString(R.string.yandex_client_secret),
                    code,
                )

            val user = yandexApi.user("${token.tokenType} ${token.accessToken}")
            println(user)

            oauthDataStore.updateData {
                oAuth {
                    accessToken = token.accessToken
                    tokenType = token.tokenType
                    userId = user.id
                }
            }
        }
    }
}


