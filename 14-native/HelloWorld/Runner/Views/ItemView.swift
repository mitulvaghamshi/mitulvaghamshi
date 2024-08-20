import SwiftUI

struct ItemView: View {
    let item: ViewModel.DataItem

    var body: some View {
        HStack {
            Image(item.image)
                .resizable()
                .clipShape(
                    RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                )
                .frame(width: 80, height: 50)

            Text(item.text)
                .font(.headline)
                .lineLimit(1)
        }
    }
}

#Preview {
    ItemView(item: ViewModel.DataItem(
        id: 0, text: "I am strong! and strong and strong", image: "image1"
    ))
}
