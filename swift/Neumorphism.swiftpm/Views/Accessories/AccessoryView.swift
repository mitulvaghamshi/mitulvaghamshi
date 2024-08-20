import SwiftUI

struct AccessoryView: View {
    var items: [AccessoryItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { $0.padding(.horizontal, 20) }
            }
            .padding(48)
        }
    }
}

#Preview("AccessoryView") {
    AccessoryView(items: Data.accessories)
}
