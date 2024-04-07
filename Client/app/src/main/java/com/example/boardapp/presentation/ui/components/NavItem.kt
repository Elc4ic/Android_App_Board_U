package com.example.boardapp.presentation.ui.components

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.ui.graphics.vector.ImageVector

sealed class NavItem(val route: String, val ladel: String, val icon: ImageVector) {
    object Home : NavItem("home", "Home", Icons.Filled.Home)
    class Detail(id:String) : NavItem("details/$id", "Details", Icons.Filled.Settings)
    object Login : NavItem("login", "Login", Icons.Filled.Person)
    object Chats : NavItem("chats", "Chats", Icons.Filled.Email)
    object Chat : NavItem("chat", "Chat", Icons.Filled.Email)
    object Profile : NavItem("profile", "Profile", Icons.Filled.Person)
    object Settings : NavItem("settings", "Settings", Icons.Filled.Settings)
    object AdList : NavItem("adList", "Main", Icons.Filled.AccountBox)
    object MyAd : NavItem("myAd", "MyAd", Icons.Filled.AccountBox)
    object AddAd : NavItem("addAd", "Add", Icons.Filled.Add)
    object Search : NavItem("search", "Search", Icons.Filled.Search)


    fun prepareNavigationBarItems(): List<NavItem> {
        val navigationBarItemsList = arrayListOf<NavItem>()

        navigationBarItemsList.add(Home)
        navigationBarItemsList.add(AdList)
        navigationBarItemsList.add(Profile)

        return navigationBarItemsList
    }
}
