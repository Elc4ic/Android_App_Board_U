package com.example.boardapp.presentation.ui.theme

import android.app.Activity
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.core.view.ViewCompat

private val DarkColors = darkColorScheme(
    primary = Purple200,
    secondary = Purple700,
    tertiary = Teal200,
    background = NightBG,
    surface = pinkText,
    onSurface = cardNight
)

private val LightColors = lightColorScheme(
    primary = Purple500,
    secondary = Purple700,
    tertiary = Teal200,
    background = LightBG,
    surface = blueText,
    onSurface = cardLight
)

@Composable
fun MyTheme(darkTheme: Boolean = isSystemInDarkTheme(),
            dynamicColor: Boolean = false,
            content: @Composable () -> Unit) {
    val colorScheme = when {
        darkTheme -> DarkColors
        else -> LightColors
    }
    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            (view.context as Activity).window.statusBarColor = colorScheme.primary.toArgb()
            ViewCompat.getWindowInsetsController(view)?.isAppearanceLightStatusBars = darkTheme
        }
    }
    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )
}