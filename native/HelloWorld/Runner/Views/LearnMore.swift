import SwiftUI

struct LearnMore: View {
    @State private var isExpanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded, content: {
            VStack(alignment: .leading, spacing: 20) {
                Text(description1)
                Text(description2)
                Text(description3)
                Text(description4)
            }
        }, label: {
            Label("Learn more", systemImage: "book")
        })
        .padding(.horizontal)
    }
}

#Preview { LearnMore() }
