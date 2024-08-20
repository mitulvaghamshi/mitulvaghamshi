package me.mitul.portfolio.android.cards

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.OpenInNew
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.ListItem
import androidx.compose.material3.ListItemDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import me.mitul.portfolio.android.R
import me.mitul.portfolio.android.common.LinkFrame
import me.mitul.portfolio.android.common.UrlFrame
import me.mitul.portfolio.shared.ExternalLink

@Composable
internal fun ExtraCard() = LazyColumn(
    state = rememberLazyListState(),
    modifier = Modifier.padding(all = 16.dp),
) {
    item { Credential() }
    item { Certificate() }
    items(items = ExternalLink.entries.take(n = 4)) { LinkFrame(link = it) }
}

@Preview
@Composable
private fun Credential() = Card(
    modifier = Modifier.padding(vertical = 8.dp),
    elevation = CardDefaults.cardElevation(defaultElevation = 0.dp),
    colors = CardDefaults.cardColors(containerColor = colorResource(id = R.color.cert_card_bg)),
) {
    Row(
        modifier = Modifier.padding(all = 16.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Image(
            painter = painterResource(id = R.drawable.img_cert_flutter_logo),
            contentDescription = stringResource(id = R.string.desc_cert_img_flutter_logo),
            modifier = Modifier.size(size = 40.dp),
        )
        Spacer(modifier = Modifier.width(width = 10.dp))
        Text(
            text = stringResource(id = R.string.cert_flutter_label),
            color = Color.White, fontSize = 20.sp, fontWeight = FontWeight.Bold,
        )
    }
    Row(
        modifier = Modifier.padding(all = 16.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
    ) {
        val labelColor = colorResource(id = R.color.cert_label_text)
        Column(verticalArrangement = Arrangement.SpaceEvenly) {
            Text(text = stringResource(R.string.cert_cred_label), color = labelColor)
            Text(
                text = stringResource(R.string.cert_cred_name),
                fontSize = 26.sp, color = Color.White
            )
            Spacer(modifier = Modifier.height(height = 30.dp))
            Text(text = stringResource(R.string.cert_owner_name_label), color = labelColor)
            Text(text = stringResource(R.string.cert_owner_name_value), color = Color.White)
            Spacer(modifier = Modifier.height(height = 20.dp))
            Text(text = stringResource(R.string.cert_issue_date_label), color = labelColor)
            Text(text = stringResource(R.string.cert_issue_date_value), color = Color.White)
        }
        Spacer(modifier = Modifier.weight(weight = 1f))
        Column(verticalArrangement = Arrangement.SpaceBetween) {
            Image(
                painter = painterResource(id = R.drawable.img_cert_clock),
                contentDescription = stringResource(R.string.desc_img_cert_clock),
                modifier = Modifier.size(size = 120.dp),
            )
            Spacer(modifier = Modifier.height(height = 30.dp))
            Text(text = stringResource(R.string.cert_cred_id_label), color = labelColor)
            Text(text = stringResource(R.string.cert_cred_id_value), color = Color.White)
        }
    }
    Image(
        painter = painterResource(id = R.drawable.img_cert_qr_code),
        contentDescription = stringResource(R.string.desc_img_cert_qr_code),
        modifier = Modifier.padding(all = 16.dp),
    )
}

@Preview
@Composable
private fun Certificate(link: ExternalLink = ExternalLink.Certificate) = UrlFrame(url = link.url) {
    Image(
        painter = painterResource(id = R.drawable.img_certificate),
        contentDescription = stringResource(R.string.cert_title_value),
        contentScale = ContentScale.FillWidth,
        modifier = Modifier.fillMaxWidth(),
    )
    ListItem(
        colors = ListItemDefaults.colors(containerColor = MaterialTheme.colorScheme.surface),
        overlineContent = {
            Text(
                text = link.url,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                color = MaterialTheme.colorScheme.tertiary,
            )
        },
        headlineContent = {
            Text(text = link.title, fontWeight = FontWeight.Bold)
        },
        supportingContent = {
            Text(text = stringResource(id = R.string.cert_desc_value))
        },
        trailingContent = {
            Icon(
                imageVector = Icons.AutoMirrored.Filled.OpenInNew,
                contentDescription = stringResource(id = R.string.open_in_browser),
            )
        }
    )
}
