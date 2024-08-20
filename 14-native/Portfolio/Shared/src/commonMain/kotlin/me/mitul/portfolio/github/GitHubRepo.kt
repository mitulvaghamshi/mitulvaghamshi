package me.mitul.portfolio.github

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class GitHubRepo(
    @SerialName("id") val id: Long,
    @SerialName("name") val name: String,
    @SerialName("html_url") val url: String,
    @SerialName("size") val size: Int,
    @SerialName("language") val language: String?,
    @SerialName("description") val description: String?,
    @SerialName("topics") val topics: List<String>,
)
