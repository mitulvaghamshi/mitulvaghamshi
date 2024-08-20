package me.mitul.portfolio.android.theme

import androidx.compose.material3.ColorScheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.ui.graphics.Color

// Extra colors
val lightTeal = Color(color = 0xff80F9F9)
val darkTeal = Color(color = 0xff03BFC8)

val lightPink = Color(color = 0xffF4B5FB)
val darkPink = Color(color = 0xffEE5FFA)

val lightBlue = Color(color = 0xffAECBFA)
val darkBlue = Color(color = 0xff8AB4F8)

val lightOrange = Color(color = 0xffFDD663)
val darkOrange = Color(color = 0xffE37400)

val lightGreen = Color(color = 0xff87FFC5)
val darkGreen = Color(color = 0xff137356)

val lightBlack = Color(color = 0xff9AA0A6)
val darkBlack = Color(color = 0xff3C4043)

val lightRed = Color(color = 0xffF6AEA9)
val darkRed = Color(color = 0xffF28B82)
val darkRed2 = Color(color = 0xffFF7575)

interface AppColorScheme {
    val lightColorScheme: ColorScheme
    val darkColorScheme: ColorScheme
}

object BlueColorScheme : AppColorScheme {
    // Blue dominated theme
    val seed = Color(0xFF8AB4F8)

    private val md_theme_light_primary = Color(0xFF255FA6)
    private val md_theme_light_onPrimary = Color(0xFFFFFFFF)
    private val md_theme_light_primaryContainer = Color(0xFFD5E3FF)
    private val md_theme_light_onPrimaryContainer = Color(0xFF001B3C)
    private val md_theme_light_secondary = Color(0xFF255FA6)
    private val md_theme_light_onSecondary = Color(0xFFFFFFFF)
    private val md_theme_light_secondaryContainer = Color(0xFFD5E3FF)
    private val md_theme_light_onSecondaryContainer = Color(0xFF001B3C)
    private val md_theme_light_tertiary = Color(0xFF00696E)
    private val md_theme_light_onTertiary = Color(0xFFFFFFFF)
    private val md_theme_light_tertiaryContainer = Color(0xFF6CF6FF)
    private val md_theme_light_onTertiaryContainer = Color(0xFF002022)
    private val md_theme_light_error = Color(0xFFBA1A1A)
    private val md_theme_light_errorContainer = Color(0xFFFFDAD6)
    private val md_theme_light_onError = Color(0xFFFFFFFF)
    private val md_theme_light_onErrorContainer = Color(0xFF410002)
    private val md_theme_light_background = Color(0xFFFDFBFF)
    private val md_theme_light_onBackground = Color(0xFF1A1C1E)
    private val md_theme_light_surface = Color(0xFFFDFBFF)
    private val md_theme_light_onSurface = Color(0xFF1A1C1E)
    private val md_theme_light_surfaceVariant = Color(0xFFE0E2EC)
    private val md_theme_light_onSurfaceVariant = Color(0xFF43474E)
    private val md_theme_light_outline = Color(0xFF74777F)
    private val md_theme_light_inverseOnSurface = Color(0xFFF1F0F4)
    private val md_theme_light_inverseSurface = Color(0xFF2F3033)
    private val md_theme_light_inversePrimary = Color(0xFFA8C8FF)
    private val md_theme_light_shadow = Color(0xFF000000)
    private val md_theme_light_surfaceTint = Color(0xFF255FA6)
    private val md_theme_light_outlineVariant = Color(0xFFC4C6CF)
    private val md_theme_light_scrim = Color(0xFF000000)

    private val md_theme_dark_primary = Color(0xFFA8C8FF)
    private val md_theme_dark_onPrimary = Color(0xFF003061)
    private val md_theme_dark_primaryContainer = Color(0xFF004689)
    private val md_theme_dark_onPrimaryContainer = Color(0xFFD5E3FF)
    private val md_theme_dark_secondary = Color(0xFFA8C8FF)
    private val md_theme_dark_onSecondary = Color(0xFF003061)
    private val md_theme_dark_secondaryContainer = Color(0xFF004689)
    private val md_theme_dark_onSecondaryContainer = Color(0xFFD5E3FF)
    private val md_theme_dark_tertiary = Color(0xFF43DAE3)
    private val md_theme_dark_onTertiary = Color(0xFF00373A)
    private val md_theme_dark_tertiaryContainer = Color(0xFF004F53)
    private val md_theme_dark_onTertiaryContainer = Color(0xFF6CF6FF)
    private val md_theme_dark_error = Color(0xFFFFB4AB)
    private val md_theme_dark_errorContainer = Color(0xFF93000A)
    private val md_theme_dark_onError = Color(0xFF690005)
    private val md_theme_dark_onErrorContainer = Color(0xFFFFDAD6)
    private val md_theme_dark_background = Color(0xFF1A1C1E)
    private val md_theme_dark_onBackground = Color(0xFFE3E2E6)
    private val md_theme_dark_surface = Color(0xFF1A1C1E)
    private val md_theme_dark_onSurface = Color(0xFFE3E2E6)
    private val md_theme_dark_surfaceVariant = Color(0xFF43474E)
    private val md_theme_dark_onSurfaceVariant = Color(0xFFC4C6CF)
    private val md_theme_dark_outline = Color(0xFF8E9199)
    private val md_theme_dark_inverseOnSurface = Color(0xFF1A1C1E)
    private val md_theme_dark_inverseSurface = Color(0xFFE3E2E6)
    private val md_theme_dark_inversePrimary = Color(0xFF255FA6)
    private val md_theme_dark_shadow = Color(0xFF000000)
    private val md_theme_dark_surfaceTint = Color(0xFFA8C8FF)
    private val md_theme_dark_outlineVariant = Color(0xFF43474E)
    private val md_theme_dark_scrim = Color(0xFF000000)

    override val lightColorScheme = lightColorScheme(
        primary = md_theme_light_primary,
        onPrimary = md_theme_light_onPrimary,
        primaryContainer = md_theme_light_primaryContainer,
        onPrimaryContainer = md_theme_light_onPrimaryContainer,
        secondary = md_theme_light_secondary,
        onSecondary = md_theme_light_onSecondary,
        secondaryContainer = md_theme_light_secondaryContainer,
        onSecondaryContainer = md_theme_light_onSecondaryContainer,
        tertiary = md_theme_light_tertiary,
        onTertiary = md_theme_light_onTertiary,
        tertiaryContainer = md_theme_light_tertiaryContainer,
        onTertiaryContainer = md_theme_light_onTertiaryContainer,
        error = md_theme_light_error,
        errorContainer = md_theme_light_errorContainer,
        onError = md_theme_light_onError,
        onErrorContainer = md_theme_light_onErrorContainer,
        background = md_theme_light_background,
        onBackground = md_theme_light_onBackground,
        surface = md_theme_light_surface,
        onSurface = md_theme_light_onSurface,
        surfaceVariant = md_theme_light_surfaceVariant,
        onSurfaceVariant = md_theme_light_onSurfaceVariant,
        outline = md_theme_light_outline,
        inverseOnSurface = md_theme_light_inverseOnSurface,
        inverseSurface = md_theme_light_inverseSurface,
        inversePrimary = md_theme_light_inversePrimary,
        surfaceTint = md_theme_light_surfaceTint,
        outlineVariant = md_theme_light_outlineVariant,
        scrim = md_theme_light_scrim,
    )

    override val darkColorScheme = darkColorScheme(
        primary = md_theme_dark_primary,
        onPrimary = md_theme_dark_onPrimary,
        primaryContainer = md_theme_dark_primaryContainer,
        onPrimaryContainer = md_theme_dark_onPrimaryContainer,
        secondary = md_theme_dark_secondary,
        onSecondary = md_theme_dark_onSecondary,
        secondaryContainer = md_theme_dark_secondaryContainer,
        onSecondaryContainer = md_theme_dark_onSecondaryContainer,
        tertiary = md_theme_dark_tertiary,
        onTertiary = md_theme_dark_onTertiary,
        tertiaryContainer = md_theme_dark_tertiaryContainer,
        onTertiaryContainer = md_theme_dark_onTertiaryContainer,
        error = md_theme_dark_error,
        errorContainer = md_theme_dark_errorContainer,
        onError = md_theme_dark_onError,
        onErrorContainer = md_theme_dark_onErrorContainer,
        background = md_theme_dark_background,
        onBackground = md_theme_dark_onBackground,
        surface = md_theme_dark_surface,
        onSurface = md_theme_dark_onSurface,
        surfaceVariant = md_theme_dark_surfaceVariant,
        onSurfaceVariant = md_theme_dark_onSurfaceVariant,
        outline = md_theme_dark_outline,
        inverseOnSurface = md_theme_dark_inverseOnSurface,
        inverseSurface = md_theme_dark_inverseSurface,
        inversePrimary = md_theme_dark_inversePrimary,
        surfaceTint = md_theme_dark_surfaceTint,
        outlineVariant = md_theme_dark_outlineVariant,
        scrim = md_theme_dark_scrim,
    )
}

object GreenColorScheme : AppColorScheme {
    // Green dominated theme
    val seed = Color(0xFF137356)

    private val md_theme_light_primary = Color(0xFF006C4F)
    private val md_theme_light_onPrimary = Color(0xFFFFFFFF)
    private val md_theme_light_primaryContainer = Color(0xFF85F8CB)
    private val md_theme_light_onPrimaryContainer = Color(0xFF002116)
    private val md_theme_light_secondary = Color(0xFF4C6358)
    private val md_theme_light_onSecondary = Color(0xFFFFFFFF)
    private val md_theme_light_secondaryContainer = Color(0xFFCFE9DA)
    private val md_theme_light_onSecondaryContainer = Color(0xFF092017)
    private val md_theme_light_tertiary = Color(0xFF3E6374)
    private val md_theme_light_onTertiary = Color(0xFFFFFFFF)
    private val md_theme_light_tertiaryContainer = Color(0xFFC2E8FD)
    private val md_theme_light_onTertiaryContainer = Color(0xFF001F2A)
    private val md_theme_light_error = Color(0xFFBA1A1A)
    private val md_theme_light_errorContainer = Color(0xFFFFDAD6)
    private val md_theme_light_onError = Color(0xFFFFFFFF)
    private val md_theme_light_onErrorContainer = Color(0xFF410002)
    private val md_theme_light_background = Color(0xFFFBFDF9)
    private val md_theme_light_onBackground = Color(0xFF191C1A)
    private val md_theme_light_surface = Color(0xFFFBFDF9)
    private val md_theme_light_onSurface = Color(0xFF191C1A)
    private val md_theme_light_surfaceVariant = Color(0xFFDBE5DE)
    private val md_theme_light_onSurfaceVariant = Color(0xFF404944)
    private val md_theme_light_outline = Color(0xFF707974)
    private val md_theme_light_inverseOnSurface = Color(0xFFEFF1EE)
    private val md_theme_light_inverseSurface = Color(0xFF2E312F)
    private val md_theme_light_inversePrimary = Color(0xFF68DBB0)
    private val md_theme_light_shadow = Color(0xFF000000)
    private val md_theme_light_surfaceTint = Color(0xFF006C4F)
    private val md_theme_light_outlineVariant = Color(0xFFBFC9C2)
    private val md_theme_light_scrim = Color(0xFF000000)

    private val md_theme_dark_primary = Color(0xFF68DBB0)
    private val md_theme_dark_onPrimary = Color(0xFF003828)
    private val md_theme_dark_primaryContainer = Color(0xFF00513B)
    private val md_theme_dark_onPrimaryContainer = Color(0xFF85F8CB)
    private val md_theme_dark_secondary = Color(0xFFB3CCBF)
    private val md_theme_dark_onSecondary = Color(0xFF1F352B)
    private val md_theme_dark_secondaryContainer = Color(0xFF354B41)
    private val md_theme_dark_onSecondaryContainer = Color(0xFFCFE9DA)
    private val md_theme_dark_tertiary = Color(0xFFA6CCE0)
    private val md_theme_dark_onTertiary = Color(0xFF093544)
    private val md_theme_dark_tertiaryContainer = Color(0xFF254B5C)
    private val md_theme_dark_onTertiaryContainer = Color(0xFFC2E8FD)
    private val md_theme_dark_error = Color(0xFFFFB4AB)
    private val md_theme_dark_errorContainer = Color(0xFF93000A)
    private val md_theme_dark_onError = Color(0xFF690005)
    private val md_theme_dark_onErrorContainer = Color(0xFFFFDAD6)
    private val md_theme_dark_background = Color(0xFF191C1A)
    private val md_theme_dark_onBackground = Color(0xFFE1E3DF)
    private val md_theme_dark_surface = Color(0xFF191C1A)
    private val md_theme_dark_onSurface = Color(0xFFE1E3DF)
    private val md_theme_dark_surfaceVariant = Color(0xFF404944)
    private val md_theme_dark_onSurfaceVariant = Color(0xFFBFC9C2)
    private val md_theme_dark_outline = Color(0xFF89938D)
    private val md_theme_dark_inverseOnSurface = Color(0xFF191C1A)
    private val md_theme_dark_inverseSurface = Color(0xFFE1E3DF)
    private val md_theme_dark_inversePrimary = Color(0xFF006C4F)
    private val md_theme_dark_shadow = Color(0xFF000000)
    private val md_theme_dark_surfaceTint = Color(0xFF68DBB0)
    private val md_theme_dark_outlineVariant = Color(0xFF404944)
    private val md_theme_dark_scrim = Color(0xFF000000)

    override val lightColorScheme = lightColorScheme(
        primary = md_theme_light_primary,
        onPrimary = md_theme_light_onPrimary,
        primaryContainer = md_theme_light_primaryContainer,
        onPrimaryContainer = md_theme_light_onPrimaryContainer,
        secondary = md_theme_light_secondary,
        onSecondary = md_theme_light_onSecondary,
        secondaryContainer = md_theme_light_secondaryContainer,
        onSecondaryContainer = md_theme_light_onSecondaryContainer,
        tertiary = md_theme_light_tertiary,
        onTertiary = md_theme_light_onTertiary,
        tertiaryContainer = md_theme_light_tertiaryContainer,
        onTertiaryContainer = md_theme_light_onTertiaryContainer,
        error = md_theme_light_error,
        errorContainer = md_theme_light_errorContainer,
        onError = md_theme_light_onError,
        onErrorContainer = md_theme_light_onErrorContainer,
        background = md_theme_light_background,
        onBackground = md_theme_light_onBackground,
        surface = md_theme_light_surface,
        onSurface = md_theme_light_onSurface,
        surfaceVariant = md_theme_light_surfaceVariant,
        onSurfaceVariant = md_theme_light_onSurfaceVariant,
        outline = md_theme_light_outline,
        inverseOnSurface = md_theme_light_inverseOnSurface,
        inverseSurface = md_theme_light_inverseSurface,
        inversePrimary = md_theme_light_inversePrimary,
        surfaceTint = md_theme_light_surfaceTint,
        outlineVariant = md_theme_light_outlineVariant,
        scrim = md_theme_light_scrim,
    )

    override val darkColorScheme = darkColorScheme(
        primary = md_theme_dark_primary,
        onPrimary = md_theme_dark_onPrimary,
        primaryContainer = md_theme_dark_primaryContainer,
        onPrimaryContainer = md_theme_dark_onPrimaryContainer,
        secondary = md_theme_dark_secondary,
        onSecondary = md_theme_dark_onSecondary,
        secondaryContainer = md_theme_dark_secondaryContainer,
        onSecondaryContainer = md_theme_dark_onSecondaryContainer,
        tertiary = md_theme_dark_tertiary,
        onTertiary = md_theme_dark_onTertiary,
        tertiaryContainer = md_theme_dark_tertiaryContainer,
        onTertiaryContainer = md_theme_dark_onTertiaryContainer,
        error = md_theme_dark_error,
        errorContainer = md_theme_dark_errorContainer,
        onError = md_theme_dark_onError,
        onErrorContainer = md_theme_dark_onErrorContainer,
        background = md_theme_dark_background,
        onBackground = md_theme_dark_onBackground,
        surface = md_theme_dark_surface,
        onSurface = md_theme_dark_onSurface,
        surfaceVariant = md_theme_dark_surfaceVariant,
        onSurfaceVariant = md_theme_dark_onSurfaceVariant,
        outline = md_theme_dark_outline,
        inverseOnSurface = md_theme_dark_inverseOnSurface,
        inverseSurface = md_theme_dark_inverseSurface,
        inversePrimary = md_theme_dark_inversePrimary,
        surfaceTint = md_theme_dark_surfaceTint,
        outlineVariant = md_theme_dark_outlineVariant,
        scrim = md_theme_dark_scrim,
    )
}
