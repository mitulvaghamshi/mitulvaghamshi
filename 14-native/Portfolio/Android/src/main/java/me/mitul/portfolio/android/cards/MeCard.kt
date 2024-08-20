package me.mitul.portfolio.android.cards

import android.content.Intent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.net.toUri
import me.mitul.portfolio.android.R
import me.mitul.portfolio.android.common.LinkFrame
import me.mitul.portfolio.android.common.UrlFrame
import me.mitul.portfolio.shared.DESCRIPTION
import me.mitul.portfolio.shared.ExternalLink
import me.mitul.portfolio.shared.SocialLink

@Preview(showBackground = true, backgroundColor = 0xfff)
@Composable
internal fun MeCard() = LazyColumn(
    state = rememberLazyListState(),
    modifier = Modifier.padding(all = 16.dp),
) {
    item { ProfilePicture() }
    item { FullName() }
    item { ButtonBar() }
    item { Description() }
    item {
        val link = ExternalLink.Copyright
        LinkFrame(link = link, leading = {
            Image(
                painter = painterResource(id = R.drawable.ic_launcher),
                contentDescription = link.title,
            )
        })
    }
}

@Composable
private fun ProfilePicture() = Image(
    painter = painterResource(id = R.drawable.img_me),
    contentDescription = stringResource(id = R.string.desc_img_me),
    modifier = Modifier
        .size(height = 350.dp, width = 260.dp)
        .clip(shape = RoundedCornerShape(size = 16.dp))
)

@Composable
private fun FullName() = Column(modifier = Modifier.padding(vertical = 8.dp)) {
    Text(
        text = stringResource(id = R.string.profile_developer_label),
        fontSize = 18.sp, fontFamily = FontFamily.Monospace,
    )
    Text(
        text = stringResource(R.string.profile_full_name), fontSize = 36.sp,
        fontWeight = FontWeight.Bold, fontFamily = FontFamily.Serif,
    )
}

@Composable
private fun Description() = UrlFrame {
    Text(
        text = DESCRIPTION,
        textAlign = TextAlign.Justify,
        modifier = Modifier.padding(all = 16.dp),
    )
}

@Composable
private fun ButtonBar() = UrlFrame {
    val context = LocalContext.current
    val onClick = { url: String ->
        context.startActivity(Intent(Intent.ACTION_VIEW, url.toUri()))
    }
    Row(
        modifier = Modifier
            .padding(all = 8.dp)
            .fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
    ) {
        SocialLink.entries.forEach { link ->
            IconButton(onClick = { onClick(link.url) }) {
                Icon(
                    painter = painterResource(id = link.icon),
                    contentDescription = link.name,
                    modifier = Modifier.size(size = 30.dp),
                )
            }
        }
    }
}

private val SocialLink.icon: Int
    get() = when (this) {
        SocialLink.Gmail -> R.drawable.ic_gmail
        SocialLink.GitHub -> R.drawable.ic_github
        SocialLink.LinkedIn -> R.drawable.ic_linkedin
        SocialLink.WhatsApp -> R.drawable.ic_whatsapp
        SocialLink.Phone -> R.drawable.ic_phone
    }
