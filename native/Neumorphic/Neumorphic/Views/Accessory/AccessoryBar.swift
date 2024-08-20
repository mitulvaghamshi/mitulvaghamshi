import SwiftUI

struct AccessoryBar: View {
    var items: [Accessory]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { AccessoryItem(accessory: $0) }
            }
            .padding(48)
        }
    }
}

#Preview("AccessoryBar") { AccessoryBar(items: Accessory.items()) }
