package me.mitul.portfolio.android.cards

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.ListItem
import androidx.compose.material3.ListItemDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import me.mitul.portfolio.android.R
import me.mitul.portfolio.android.common.LinkFrame
import me.mitul.portfolio.android.common.UrlFrame
import me.mitul.portfolio.shared.Education
import me.mitul.portfolio.shared.ExternalLink

@Composable
internal fun EduCard() = LazyColumn(
    state = rememberLazyListState(),
    modifier = Modifier.padding(all = 16.dp),
) {
    items(items = Education.entries) { EduItem(edu = it) }
    item { WesEvaluation() }
    item { LinkFrame(link = ExternalLink.WesEval) }
    item { LinkFrame(link = ExternalLink.WesReport) }
}

@Preview
@Composable
private fun WesEvaluation() = UrlFrame {
    Image(
        painter = painterResource(id = R.drawable.img_wes_logo),
        contentDescription = stringResource(id = R.string.desc_img_wes_logo),
        modifier = Modifier
            .padding(all = 16.dp)
            .aspectRatio(ratio = 1f)
    )
    Text(
        text = stringResource(id = R.string.wes_qualification_label),
        fontSize = 24.sp,
        textAlign = TextAlign.Center,
        fontWeight = FontWeight.Bold,
        fontFamily = FontFamily.Serif,
        modifier = Modifier.padding(vertical = 16.dp, horizontal = 16.dp),
    )
}

@Composable
private fun EduItem(edu: Education) = UrlFrame(url = edu.url) {
    Image(
        painter = painterResource(id = edu.getPoster()),
        contentScale = ContentScale.FillWidth,
        contentDescription = edu.title,
        modifier = Modifier.fillMaxWidth(),
    )
    ListItem(
        colors = ListItemDefaults.colors(containerColor = MaterialTheme.colorScheme.surface),
        leadingContent = {
            Image(
                painter = painterResource(id = edu.getLogo()),
                contentDescription = edu.title,
            )
        },
        overlineContent = {
            Text(
                text = edu.url,
                maxLines = 1,
                color = MaterialTheme.colorScheme.primary,
                overflow = TextOverflow.Ellipsis,
            )
        },
        headlineContent = {
            Text(
                text = edu.title,
                fontSize = 22.sp,
                fontWeight = FontWeight.Bold
            )
        },
        supportingContent = {
            Column(modifier = Modifier.padding(top = 8.dp)) {
                Text(text = edu.year, fontWeight = FontWeight.Bold)
                Text(text = edu.major, fontWeight = FontWeight.Bold)
                Text(text = edu.address)
            }
        },
        trailingContent = {
            Text(text = edu.duration, fontWeight = FontWeight.Bold)
        }
    )
}

@Preview
@Composable
private fun EduItem_Preview() = EduItem(edu = Education.MohawkCollege)

private fun Education.getLogo(): Int = when (this) {
    Education.MohawkCollege -> R.drawable.img_mohawk_logo
    Education.AmrutInstitute -> R.drawable.img_amrut_logo
}

private fun Education.getPoster(): Int = when (this) {
    Education.MohawkCollege -> R.drawable.img_mohawk_poster
    Education.AmrutInstitute -> R.drawable.img_amrut_poster
}
