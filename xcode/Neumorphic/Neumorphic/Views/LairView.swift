import SwiftUI

struct LairView: View {
    @State private var prigress1: Double = 0.42
    @State private var prigress2: Double = 0.86

    init() {
        UINavigationBar.appearance()
            .largeTitleTextAttributes = [.foregroundColor: UIColor.lairDarkGray]
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.lairBackgroundGray.edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    AccessoryBar(items: Accessory.items())

                    ProgressBar(percent: $prigress1, title: "Death Ray Charge")
                        .frame(height: 50)

                    ProgressBar(percent: $prigress2, title: "Weather Machine Construction")
                        .frame(height: 50)
                }
                .navigationBarTitle(Text("Nuemorphic"))
                .navigationBarItems(trailing: profileView())
            }
        }
    }
}

extension LairView {
    @ViewBuilder private func profileView() -> some View {
        LinearGradient.lairHorizontalDark
            .frame(width: 24, height: 24)
            .mask(Image(systemName: "person.crop.circle"))
            .padding()
    }
}

#Preview("LairView") { LairView() }
