import SwiftUI

struct TabBar: View {
    let items: [TabItem]

    var body: some View {
        HStack {
            Spacer()
            ForEach(items) { item in item.padding(.horizontal) }
            Spacer()
        }
        .padding(20)
    }
}

#Preview("TabBarView") {
    TabBar(items: [
        TabItem(icon: "pencil.tip", selected: true) {},
        TabItem(icon: "video.circle", selected: false) {},
        TabItem(icon: "gear", selected: false) {},
    ])
}
