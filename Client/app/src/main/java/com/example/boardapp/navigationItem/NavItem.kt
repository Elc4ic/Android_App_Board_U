package com.example.boardapp.navigationItem

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Email
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Settings
import androidx.compose.ui.graphics.vector.ImageVector

sealed class NavItem(val route: String, val ladel: String, val icon: ImageVector) {
    object Home : NavItem("home", "Home", Icons.Filled.Home)
    object Details : NavItem("details", "Details", Icons.Filled.Settings)
    object Login : NavItem("login", "Login", Icons.Filled.Person)
    object Chats : NavItem("chats", "Chats", Icons.Filled.Email)
    object Profile : NavItem("profile", "Profile", Icons.Filled.Person)
    object Settings : NavItem("settings", "Settings", Icons.Filled.Settings)


    fun prepareNavigationBarItems(): List<NavItem> {
        val navigationBarItemsList = arrayListOf<NavItem>()

        navigationBarItemsList.add(Home)
        navigationBarItemsList.add(Chats)
        navigationBarItemsList.add(Profile)
        navigationBarItemsList.add(Settings)

        return navigationBarItemsList
    }
}
