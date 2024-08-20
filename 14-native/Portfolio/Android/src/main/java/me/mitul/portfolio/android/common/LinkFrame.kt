package me.mitul.portfolio.android.common

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.OpenInNew
import androidx.compose.material3.Icon
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import me.mitul.portfolio.android.R
import me.mitul.portfolio.shared.ExternalLink

@Composable
internal fun LinkFrame(
    link: ExternalLink,
    leading: (@Composable () -> Unit)? = null
) = UrlFrame(url = link.url) {
    ListItem(
        leadingContent = {
            leading?.invoke()
        },
        headlineContent = {
            Text(text = link.title, fontWeight = FontWeight.Bold)
        },
        overlineContent = {
            Text(
                text = link.url,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                color = MaterialTheme.colorScheme.primary,
            )
        },
        trailingContent = {
            if (leading == null) Icon(
                imageVector = Icons.AutoMirrored.Filled.OpenInNew,
                contentDescription = stringResource(R.string.open_in_browser),
            )
        }
    )
}

@Preview
@Composable
private fun FrameLink_Preview() = LinkFrame(link = ExternalLink.Privacy)
