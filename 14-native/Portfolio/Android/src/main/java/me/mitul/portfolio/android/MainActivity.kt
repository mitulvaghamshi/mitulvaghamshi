package me.mitul.portfolio.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import me.mitul.portfolio.android.cards.EduCard
import me.mitul.portfolio.android.cards.ExtraCard
import me.mitul.portfolio.android.cards.MeCard
import me.mitul.portfolio.android.cards.RepoCard
import me.mitul.portfolio.android.common.AppScaffold
import me.mitul.portfolio.android.theme.AppTheme
import me.mitul.portfolio.shared.NavTab

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            AppTheme {
                AppScaffold(splash = true) {
                    when (it) {
                        NavTab.ItsMe -> MeCard()
                        NavTab.Education -> EduCard()
                        NavTab.Repos -> RepoCard()
                        NavTab.More -> ExtraCard()
                    }
                }
            }
        }
    }
}
