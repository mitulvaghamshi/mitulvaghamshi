import SwiftUI

struct DetailsView: View {
    let item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(item.image)
                .resizable()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
                .aspectRatio(contentMode: .fit)
            
            Text(item.text)
                .font(.title)
            
            Color.pink
                .frame(height: 10)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
        }                
        .padding()
        .navigationTitle("Affirmation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailsView(item: affirmations[0])
}
