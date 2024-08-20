package me.mitul.portfolio.android

import android.app.Application
import me.mitul.portfolio.AndroidDriverFactory
import me.mitul.portfolio.android.model.RepoModel
import me.mitul.portfolio.github.GitHubApi
import me.mitul.portfolio.github.GitHubSdk
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.GlobalContext.startKoin
import org.koin.core.module.dsl.viewModel
import org.koin.dsl.module

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        startKoin {
            androidContext(this@MainApplication)
            modules(appModule)
        }
    }
}

private val appModule = module {
    single<GitHubApi> {
        GitHubApi()
    }

    single<GitHubSdk> {
        GitHubSdk(AndroidDriverFactory(androidContext()), api = get())
    }

    viewModel {
        RepoModel(sdk = get())
    }
}
