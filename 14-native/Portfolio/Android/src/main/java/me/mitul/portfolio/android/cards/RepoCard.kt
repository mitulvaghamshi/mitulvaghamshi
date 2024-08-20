package me.mitul.portfolio.android.cards

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.lazy.staggeredgrid.LazyHorizontalStaggeredGrid
import androidx.compose.foundation.lazy.staggeredgrid.StaggeredGridCells
import androidx.compose.foundation.lazy.staggeredgrid.items
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
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
import me.mitul.portfolio.android.common.UrlFrame
import me.mitul.portfolio.android.model.RepoModel
import me.mitul.portfolio.github.GitHubRepo
import me.mitul.portfolio.shared.sampleRepo
import org.koin.androidx.compose.koinViewModel
import kotlin.math.ceil

@Composable
internal fun RepoCard() {
    val model = koinViewModel<RepoModel>()
    val state by remember { model.state }
    if (state.loading) {
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
            CircularProgressIndicator()
        }
    } else {
        RepoCard(repos = state.repos, onRefresh = model::loadRepos)
    }
    LaunchedEffect(key1 = Unit) { model.loadRepos() }
}

@Composable
private fun RepoCard(repos: List<GitHubRepo>, onRefresh: () -> Unit) = LazyColumn(
    state = rememberLazyListState(),
    modifier = Modifier.padding(all = 16.dp),
) {
    item {
        Button(onClick = onRefresh) {
            Text(
                text = stringResource(id = R.string.clear_cache),
                textAlign = TextAlign.Center,
                modifier = Modifier.fillMaxWidth(),
            )
        }
    }
    items(items = repos, key = { it.id }) { RepoItem(repo = it) }
}

@Composable
private fun RepoItem(repo: GitHubRepo) = UrlFrame(url = repo.url) {
    ListItem(
        overlineContent = {
            Text(
                text = repo.url,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                color = MaterialTheme.colorScheme.primary,
            )
        },
        headlineContent = {
            Row(
                modifier = Modifier.padding(vertical = 8.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                GithubLogo()
                Text(
                    text = repo.name,
                    fontSize = 22.sp,
                    fontWeight = FontWeight.Bold,
                    fontFamily = FontFamily.Serif,
                )
            }
        },
        supportingContent = {
            val content = stringResource(
                id = R.string.repo_lang_and_size,
                repo.language ?: stringResource(id = R.string.markdown),
                repo.size.toMemory
            )
            Column {
                Text(
                    text = content,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.onSecondaryContainer,
                )
                Text(
                    text = repo.description ?: stringResource(id = R.string.no_description),
                    fontSize = 12.sp,
                    modifier = Modifier.padding(vertical = 8.dp)
                )
                if (repo.topics.isNotEmpty()) TopicRow(topics = repo.topics)
            }
        }
    )
}

@Composable
private fun TopicRow(topics: List<String>) {
    val count = ceil(x = topics.size / 3.0).toInt()
        .coerceIn(minimumValue = 1, maximumValue = 2)
    LazyHorizontalStaggeredGrid(
        modifier = Modifier.height(height = (count * 30).dp),
        rows = StaggeredGridCells.Fixed(count = count),
        horizontalItemSpacing = 4.dp,
    ) {
        items(items = topics) { TopicChip(label = it) }
    }
}

@Composable
private fun TopicChip(label: String) = Card(modifier = Modifier.padding(vertical = 4.dp)) {
    Text(
        text = label,
        fontSize = 14.sp,
        fontWeight = FontWeight.Bold,
        modifier = Modifier.padding(horizontal = 10.dp),
    )
}

@Composable
private fun GithubLogo() = Icon(
    painter = painterResource(id = R.drawable.ic_github),
    contentDescription = stringResource(id = R.string.open_in_browser),
    modifier = Modifier.padding(end = 8.dp)
)

@Preview
@Composable
private fun RepoItem_Preview() = RepoItem(repo = sampleRepo)

private val Int.toMemory: String
    get() = if (this / 1024 <= 0) "$this KB" else "${this / 1024}.${this % 1024 / 10} MB"
