package com.example.boardapp.navigation

import androidx.annotation.StringRes
import com.example.boardapp.R

sealed class Screen(val route: String, @StringRes val resourceId: Int) {
    object Home : Screen("home", R.string.text_home)
    object Details : Screen("details", R.string.text_details)
}
/*
fun createRoute(id: Int) = "details/$id"
fun getArgumentId(entry: NavBackStackEntry): Int {
    return entry.arguments?.getString("id")?.toInt() ?: 0
}*/
