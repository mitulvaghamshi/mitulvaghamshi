package me.mitul.portfolio.android.model

import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import me.mitul.portfolio.github.GitHubRepo
import me.mitul.portfolio.github.GitHubSdk

internal data class DataState(
    val loading: Boolean = false,
    val repos: List<GitHubRepo> = emptyList()
)

internal class RepoModel(private val sdk: GitHubSdk) : ViewModel() {
    private val _state = mutableStateOf(DataState())
    val state: State<DataState> = _state

    fun loadRepos() {
        if (state.value.repos.isNotEmpty()) return
        _state.value = _state.value.copy(loading = true, repos = emptyList())
        viewModelScope.launch {
            try {
                delay(timeMillis = 2000L)
                _state.value = _state.value.copy(loading = false, repos = sdk.getRepos())
            } catch (e: Exception) {
                _state.value = _state.value.copy(loading = false, repos = emptyList())
            }
        }
    }
}
