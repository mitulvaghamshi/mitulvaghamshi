package me.mitul.portfolio.android.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext

@Composable
internal fun AppTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    colorScheme: AppColorScheme = GreenColorScheme,
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit,
) {
    val scheme = when {
        dynamicColor -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context)
            else dynamicLightColorScheme(context)
        }

        darkTheme -> colorScheme.darkColorScheme
        else -> colorScheme.lightColorScheme
    }

    MaterialTheme(colorScheme = scheme, content = content)
}
