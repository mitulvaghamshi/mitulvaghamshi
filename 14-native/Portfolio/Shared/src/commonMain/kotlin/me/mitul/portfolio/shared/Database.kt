package me.mitul.portfolio.shared

import me.mitul.portfolio.DriverFactory
import me.mitul.portfolio.RepoDatabase
import me.mitul.portfolio.github.GitHubRepo

class Database(factory: DriverFactory, db: RepoDatabase = RepoDatabase(factory.driver)) {
    private val queries = db.repoDatabaseQueries
    private val topics = { id: Long -> queries.selectTopicsByRepoId(id).executeAsList() }

    internal val repos = queries.selectRepos(::mapRepo).executeAsList()

    internal fun insertAll(repos: List<GitHubRepo>, reset: Boolean) = queries.transaction {
        if (reset) {
            queries.removeTopics()
            queries.removeRepos()
        }
        repos.forEach(insert)
    }

    private val insert = { repo: GitHubRepo ->
        queries.insertRepo(
            id = repo.id,
            name = repo.name,
            url = repo.url,
            size = repo.size.toLong(),
            language = repo.language,
            description = repo.description,
        )
        repo.topics.forEach {
            queries.insertTopic(topic_name = it, repo_id = repo.id)
        }
    }

    private fun mapRepo(
        id: Long,
        name: String,
        url: String,
        size: Long,
        language: String?,
        description: String?,
    ) = GitHubRepo(
        id = id,
        name = name,
        url = url,
        size = size.toInt(),
        language = language,
        description = description,
        topics = topics(id),
    )
}
