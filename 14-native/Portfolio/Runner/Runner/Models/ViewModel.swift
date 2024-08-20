//
//  ViewModel.swift
//  Portfolio
//
//  Created by Mitul Vaghamshi on 2023-06-12.
//  Copyright © 2023 me.mitul. All rights reserved.
//

import os
import Shared

@MainActor class ViewModel: ObservableObject {
    @Published var state: DataState = .loading

    private let helper = KoinHelper()

    static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: ViewModel.self)
    )
}

extension ViewModel {
    enum DataState {
        case loading
        case error(String)
        case data([GitHubRepo])
    }

    func loadRepos() {
        state = .loading
        Task {
            do {
                let repos = try await helper.getRepos(fetch: false)
                state = .data(repos)
            } catch {
                state = .error("Unable to fetch GitHub Repos 💔.")
            }
        }
    }
}
