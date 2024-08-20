package me.mitul.portfolio.shared

import me.mitul.portfolio.getPlatform
import me.mitul.portfolio.github.GitHubRepo

enum class NavTab { ItsMe, Education, Repos, More }

enum class SocialLink(val url: String) {
    Gmail(url = "mailto:mitulvaghmashi@gmail.com"),
    GitHub(url = "https://github.com/mitulvaghamshi"),
    LinkedIn(url = "https://www.linkedin.com/in/mitulvaghamshi"),
    WhatsApp(url = "https://api.whatsapp.com/send?phone=12899330783"),
    Phone(url = "tel:12899330783"),
}

enum class ExternalLink(val title: String, val url: String) {
    Resume(
        title = "Download Resume",
        url = "https://mitulvaghamshi.github.io/resume/resume.pdf",
    ),
    Portfolio(
        title = "Portfolio app (Flutter Web)",
        url = "https://mitulvaghamshi.github.io",
    ),
    Html(
        title = "View Html Version",
        url = "https://mitulvaghamshi.github.io/resume",
    ),
    Privacy(
        title = "Privacy Policy",
        url = "https://mitulvaghamshi.github.io/resume/policy.html",
    ),
    WesEval(
        title = "Verify Evaluation",
        url = "https://www.credly.com/badges/b78c680a-1a8b-49df-a97d-cf08ef481db9",
    ),
    WesReport(
        title = "Access Evaluation Report",
        url = "https://badges.wes.org/Evidence?type=ca&i=3794f10a-19b3-47f0-82bd-393315bc6584",
    ),
    Certificate(
        title = "Flutter Clock Challenge",
        url = "https://www.credential.net/21acfbc9-04fe-462f-954e-05f20f420da1",
    ),
    Copyright(
        title = "Copyright © Portfolio,\nMitul Vaghamshi, ${getPlatform().year}.",
        url = "https://mitulvaghamshi.github.io",
    ),
}

enum class Education(
    val title: String,
    val duration: String,
    val year: String,
    val major: String,
    val address: String,
    val url: String,
) {
    MohawkCollege(
        title = "Mohawk College",
        duration = "2 years",
        year = "2020 - 2021",
        major = "Computer System Technician",
        address = "Hamilton, Ontario, Canada.",
        url = "https://www.mohawkcollege.ca",
    ),
    AmrutInstitute(
        title = "Amrut Institute",
        duration = "3 years",
        year = "2014 - 2017",
        major = "Diploma in Computer Engineering",
        address = "Junagadh, Gujarat, India.",
        url = "https://www.aij.ind.in",
    ),
}

val sampleRepo = GitHubRepo(
    id = 0,
    name = "Remarkable Repo",
    url = "https://github.com/mitulvaghamshi",
    size = 100,
    language = "Markdown",
    description = "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, " +
            "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    topics = listOf("Sample", "App", "Portfolio", "Coding")
)

const val DESCRIPTION = "Software developer with expertise in CS and software engineering " +
        "principles. Proficient in various programming languages and committed to writing clean, " +
        "well-documented code. Passionate about staying current with industry trends and " +
        "driving innovation. Eager to collaborate and contribute to successful projects."
