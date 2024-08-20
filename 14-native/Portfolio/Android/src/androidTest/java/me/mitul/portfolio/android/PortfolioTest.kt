package me.mitul.portfolio.android

import androidx.compose.ui.test.assertHasClickAction
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import me.mitul.portfolio.android.common.SplashScreen
import org.junit.Rule
import org.junit.Test

class PortfolioTest {
    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun splashScreenTest() {
        composeTestRule.setContent { SplashScreen {} }

        composeTestRule
            .onNodeWithText(text = "Continue")
            .assertExists()
            .assertHasClickAction()
            .performClick()
    }
}
