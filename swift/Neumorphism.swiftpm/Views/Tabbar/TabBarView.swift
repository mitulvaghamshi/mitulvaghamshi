import SwiftUI

struct TabBarView: View {
    @Binding var selectedItem: SelectedItem
    
    var tabBarItems: [TabBarItem]
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(tabBarItems) { item in
                item.padding(.horizontal)
            }
            Spacer()
        }
        .padding(20)
    }
}

#Preview("TabBarView") {
    TabBarView(selectedItem: .constant(.lair), tabBarItems: Data.tabBarItems)
}
