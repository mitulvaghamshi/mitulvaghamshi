import SwiftUI

struct DetailsView: View {
    let item: ViewModel.DataItem

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(item.image)
                .resizable()
                .clipShape(
                    RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                )
                .aspectRatio(contentMode: .fit)

            Text(item.text)
                .font(.title)

            Capsule()
                .foregroundStyle(.pink)
                .frame(height: 16)
        }
        .padding()
        .navigationTitle("Affirmation")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview {
    DetailsView(item: ViewModel.DataItem(
        id: 0, text: "I am strong!", image: "image1"
    ))
}
