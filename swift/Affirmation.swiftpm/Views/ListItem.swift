import SwiftUI

struct ListItem: View {
    let item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(item.image)
                .resizable()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
                .aspectRatio(16/9, contentMode: .fit)

            Text(item.text)
                .font(.headline)
                .lineLimit(1)
        }
        .padding()
    }
}

#Preview {
    ListItem(item: affirmations[0])
}
