import SwiftUI

struct CardView: View {
    let title: String

    var body: some View {
        ZStack {
            Color.lairBackgroundGray.edgesIgnoringSafeArea(.all)
            VStack {
                Text(title)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
                    .frame(width: 150, height: 70)
                    .background(innerShadow())
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .color1, radius: 20, x: 20, y: 20)
                    .shadow(color: .color2, radius: 20, x: -20, y: -20)
            }
            .frame(width: 300, height: 400)
            .background(Color.lairBackgroundGray)
            .cornerRadius(16)
            .shadow(color: .color1, radius: 10, x: 10, y: 10)
            .shadow(color: .color2, radius: 10, x: -10, y: -10)
        }
    }
}

extension CardView {
    @ViewBuilder private func innerShadow() -> some View {
        ZStack {
            Color.color4
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(.white)
                .blur(radius: 4)
                .offset(x: -8, y: -8)
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.color5, Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .padding(2)
                .blur(radius: 2)
        }
    }
}

#Preview("CardView") { CardView(title: "Hello World!") }
