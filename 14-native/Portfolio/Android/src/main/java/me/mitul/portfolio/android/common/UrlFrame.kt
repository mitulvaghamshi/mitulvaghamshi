package me.mitul.portfolio.android.common

import android.content.Intent
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.core.net.toUri
import me.mitul.portfolio.android.R

@Composable
internal fun UrlFrame(url: String? = null, content: @Composable ColumnScope.() -> Unit) {
    val context = LocalContext.current
    val onClick = {
        if (!url.isNullOrBlank()) context.startActivity(
            Intent(Intent.ACTION_VIEW, url.toUri())
        )
    }
    Card(
        modifier = Modifier.padding(vertical = 8.dp),
        elevation = CardDefaults.outlinedCardElevation(),
        colors = CardDefaults.outlinedCardColors(),
        onClick = onClick, content = content,
    )
}

@Preview
@Composable
private fun Frame_Preview() = UrlFrame {
    Text(
        text = stringResource(id = R.string.btn_continue),
        modifier = Modifier.padding(all = 8.dp),
    )
}
