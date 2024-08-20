import SwiftUI

struct TabItem: View, Identifiable {
    var icon: String
    let selected: Bool
    let action: () -> Void

    internal let id: UUID = UUID()
    internal let size: CGFloat = 32

    var body: some View {
        Button(action: action) {
            if selected { buttonDown() } else { buttonUp() }
        }
    }
}

extension TabItem {
    @ViewBuilder private func buttomMask() -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(width: size * 2, height: size * 2)
            Image(systemName: self.icon)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
    }

    @ViewBuilder private func buttonUp() -> some View {
        ZStack {
            LinearGradient.lairHorizontalDarkReverse
                .frame(width: size, height: size)
            Rectangle()
                .inverseMask(buttomMask())
                .frame(width: size * 2, height: size * 2)
                .foregroundColor(.lairBackgroundGray)
                .shadow(color: .lairShadowGray, radius: 3, x: 3, y: 3)
                .shadow(color: .white, radius: 3, x: -3, y: -3)
                .clipShape(RoundedRectangle(cornerRadius: size * 8 / 16))
        }
        .compositingGroup()
        .shadow(color: Color.white.opacity(0.9), radius: 10, x: -5, y: -5)
        .shadow(color: Color.lairShadowGray.opacity(0.5), radius: 10, x: 5, y: 5)
    }

    @ViewBuilder private func buttonDown() -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.lairBackgroundGray)
                .frame(width: size * 2.25, height: size * 2.25)
                .cornerRadius(size * 8 / 16)

            Rectangle()
                .foregroundColor(.lairBackgroundGray)
                .frame(width: size * 2.25, height: size * 2.25)
                .cornerRadius(size * 8 / 16)
                .inverseMask(Rectangle()
                    .cornerRadius(size * 6 / 16)
                    .padding(size / 8)
                )
                .shadow(
                    color: Color.lairShadowGray.opacity(0.7),
                    radius: size * 0.1875,
                    x: size * 0.1875, y: size * 0.1875)
                .shadow(
                    color: Color(white: 1.0).opacity(0.9),
                    radius: size * 0.1875,
                    x: -size * 0.1875, y: -size * 0.1875)
                .clipShape(RoundedRectangle(cornerRadius: size * 8 / 16))

            LinearGradient.lairHorizontalDarkReverse
                .frame(width: size, height: size)
                .mask(Image(systemName: self.icon)
                    .resizable()
                    .scaledToFit()
                )
                .shadow(
                    color: Color.lairShadowGray.opacity(0.5),
                    radius: size * 0.1875,
                    x: size * 0.1875, y: size * 0.1875)
                .shadow(
                    color: Color(white: 1.0).opacity(0.9),
                    radius: size * 0.1875,
                    x: -size * 0.1875, y: -size * 0.1875)
        }
        .compositingGroup()
        .overlay(
            RoundedRectangle(cornerRadius: size * 8 / 16)
                .stroke(LinearGradient.lairDiagonalLightBorder, lineWidth: 2)
        )
    }
}

extension View {
    func inverseMask<Mask>(_ mask: Mask) -> some View where Mask : View {
        self.mask(mask
            .foregroundColor(.black)
            .background(Color.white)
            .compositingGroup()
            .luminanceToAlpha()
        )
    }
}

#Preview("TabBarItem") {
    TabItem(icon: "pencil.tip", selected: true) {}
}
