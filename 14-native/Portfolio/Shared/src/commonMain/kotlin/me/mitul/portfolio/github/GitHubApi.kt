package me.mitul.portfolio.github

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.get
import io.ktor.client.request.header
import io.ktor.client.request.parameter
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json

class GitHubApi {
    private val endpoint = "https://api.github.com/users/mitulvaghamshi/repos"

    private val client = HttpClient {
        install(ContentNegotiation) {
            json(Json { ignoreUnknownKeys = true })
        }
    }

    @Throws(Exception::class)
    internal suspend fun getRepos(limit: Int = 30): List<GitHubRepo> = client.get(endpoint) {
        header("Accept", "application/vnd.github+json")
        parameter("per_page", limit)
    }.body()
}
