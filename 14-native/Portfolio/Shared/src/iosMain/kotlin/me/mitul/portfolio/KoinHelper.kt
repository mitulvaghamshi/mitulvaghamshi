package me.mitul.portfolio

import me.mitul.portfolio.github.GitHubApi
import me.mitul.portfolio.github.GitHubRepo
import me.mitul.portfolio.github.GitHubSdk
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.context.startKoin
import org.koin.dsl.module

class KoinHelper : KoinComponent {
    private val sdk: GitHubSdk by inject<GitHubSdk>()

    suspend fun getRepos(fetch: Boolean): List<GitHubRepo> {
        return sdk.getRepos(fetch = fetch)
    }
}

fun initKoin() {
    startKoin {
        modules(module {
            single<GitHubApi> { GitHubApi() }
            single<GitHubSdk> { GitHubSdk(IOSDriverFactory(), api = get()) }
        })
    }
}
