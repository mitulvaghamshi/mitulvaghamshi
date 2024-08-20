package me.mitul.portfolio.android.common

import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.Segment
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.Code
import androidx.compose.material.icons.filled.School
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.LargeTopAppBar
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import me.mitul.portfolio.shared.NavTab

@Composable
internal fun AppScaffold(splash: Boolean = true, content: @Composable (NavTab) -> Unit) {
    if (splash) SplashScreen { AppScaffold(content) } else AppScaffold(content)
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun AppScaffold(content: @Composable (NavTab) -> Unit) {
    val behavior = TopAppBarDefaults.enterAlwaysScrollBehavior()
    val (tab, setTab) = remember { mutableStateOf(value = NavTab.ItsMe) }
    Scaffold(
        modifier = Modifier.nestedScroll(behavior.nestedScrollConnection),
        topBar = { LargeTopAppBar(behavior = behavior, tab = tab) },
        bottomBar = { NavigationBar(tab = tab, onChange = setTab) }
    ) {
        Surface(modifier = Modifier.padding(paddingValues = it)) { content(tab) }
    }
}

@Composable
@OptIn(ExperimentalMaterial3Api::class)
private fun LargeTopAppBar(behavior: TopAppBarScrollBehavior, tab: NavTab) = LargeTopAppBar(
    scrollBehavior = behavior, title = {
        Text(
            text = tab.name,
            maxLines = 1,
            fontWeight = FontWeight.Bold,
            fontFamily = FontFamily.Serif,
            overflow = TextOverflow.Ellipsis,
        )
    }
)

@Composable
private fun NavigationBar(tab: NavTab, onChange: (NavTab) -> Unit) = NavigationBar {
    NavTab.entries.forEach {
        NavigationBarItem(
            icon = { Icon(imageVector = it.getIcon(), contentDescription = it.name) },
            label = { Text(text = it.name) },
            selected = tab == it,
            onClick = { onChange(it) },
        )
    }
}

private fun NavTab.getIcon() = when (this) {
    NavTab.ItsMe -> Icons.Default.AccountCircle
    NavTab.Education -> Icons.Default.School
    NavTab.Repos -> Icons.Default.Code
    NavTab.More -> Icons.AutoMirrored.Filled.Segment
}

@Preview
@Composable
private fun AppScaffold_Preview() = AppScaffold(splash = false) {}
