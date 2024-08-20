//
//  ContentView.swift
//  Neumorphic
//
//  Created by Mitul Vaghamshi on 2025-02-16.
//

import SwiftUI

struct ContentView: View {
    @State private var selected: Tab = .lair

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    switch selected {
                        case .lair: LairView()
                        case .camera: CardView(title: "Camera")
                        case .settings: CardView(title: "Settings")
                    }
                }
                TabBar(items: [
                    TabItem(icon: "pencil.tip", selected: selected == .lair) {
                        selected = .lair
                    },
                    TabItem(icon: "video.circle", selected: selected == .camera) {
                        selected = .camera
                    },
                    TabItem(icon: "gear", selected: selected == .settings) {
                        selected = .settings
                    }
                ])
                .padding(.bottom, geometry.safeAreaInsets.bottom / 2)
                .background(Color.lairBackgroundGray)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview { ContentView() }
