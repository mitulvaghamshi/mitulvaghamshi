package me.mitul.portfolio.github

import me.mitul.portfolio.DriverFactory
import me.mitul.portfolio.shared.Database

class GitHubSdk(factory: DriverFactory, private val api: GitHubApi) {
    private val database = Database(factory)

    @Throws(Exception::class)
    suspend fun getRepos(fetch: Boolean = false): List<GitHubRepo> {
        val repos = if (fetch) emptyList() else database.repos
        return repos.ifEmpty {
            api.getRepos().also {
                database.insertAll(repos = it, reset = true)
            }
        }
    }
}
