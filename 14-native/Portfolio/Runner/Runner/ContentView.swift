import SwiftUI
import Shared

struct ContentView: View {
    @State private var selection: NavTab = .itsme

    var body: some View {
        TabView(selection: $selection) {
            MeCard()
                .tag(NavTab.itsme)
                .tabItem { IntroLabel }

            EduCard()
                .tag(NavTab.education)
                .tabItem { EduLabel }

            RepoCard(model: .init())
                .tag(NavTab.repos)
                .tabItem { RepoLabel }
        }
    }
}

private extension ContentView {
    @ViewBuilder var IntroLabel: some View {
        Label(NavTab.itsme.name, systemImage: "person")
    }

    @ViewBuilder var EduLabel: some View {
        Label(NavTab.education.name, systemImage: "graduationcap")
    }

    @ViewBuilder var RepoLabel: some View {
        Label(NavTab.repos.name, systemImage: "chevron.left.forwardslash.chevron.right")
    }
}

#Preview { ContentView() }
