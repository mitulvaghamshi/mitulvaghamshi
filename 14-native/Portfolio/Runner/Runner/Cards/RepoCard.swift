//
//  RepoCard.swift
//  Runner
//
//  Created by Mitul Vaghamshi on 2023-06-15.
//  Copyright © 2023 me.mitul. All rights reserved.
//

import SwiftUI
import Shared

struct RepoCard: View {
    @ObservedObject private(set) var model: ViewModel

    var body: some View {
        NavigationView {
            switch model.state {
                case .loading:
                    ProgressView()
                case .error(_):
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(.secondary)
                case .data(let items):
                    List(items, rowContent: buildRepoItem)
                        .navigationTitle("GitHub Repos")
            }
        }
        .onAppear(perform: model.loadRepos)
    }
}

private extension RepoCard {
    @ViewBuilder private func buildRepoItem(_ repo: GitHubRepo) -> some View {
        NavigationLink(destination: RepoDetails(repo: repo)) {
            Label(repo.name, image: "GitHub")
        }
    }
}

extension GitHubRepo: @retroactive Identifiable {}

#Preview { RepoCard(model: .init()) }
