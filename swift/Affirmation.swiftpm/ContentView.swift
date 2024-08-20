import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                LearnMore()

                List(affirmations) { item in
                    NavigationLink(item.text) {
                        DetailsView(item: item)
                    }
                    .lineLimit(1)
                    .listRowSeparatorTint(.pink)
                }
                .listStyle(.inset)
            }
            .navigationTitle("Affirmation")
        }
    }
}

#Preview {
    ContentView()
}
