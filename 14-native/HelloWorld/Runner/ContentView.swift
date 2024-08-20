//
//  ContentView.swift
//  HelloWorld
//
//  Created by Mitul Vaghamshi on 2025-02-16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var model: ViewModel

    var body: some View {
        NavigationView {
            switch (model.state) {
                case .loading:
                    ProgressView()
                case .error(let err):
                    Text("Error: \(err)")
                        .foregroundStyle(.red)
                case .data(let items):
                    VStack {
                        List(items) { item in
                            NavigationLink(destination: {
                                DetailsView(item: item)
                            }, label: {
                                ItemView(item: item)
                            })
                            .lineLimit(1)
                        }
                        LearnMore()
                    }
                    .navigationTitle("Affirmation")
            }
        }
        .onAppear(perform: model.fetch)
    }
}

#Preview { ContentView(model: .init()) }
