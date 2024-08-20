import SwiftUI

struct ProgressBar: View {
    @Binding var percent: Double
    let title: String

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(title)
                        .foregroundColor(.lairDarkGray).bold()
                    Spacer()
                    Text("\(Int(percent * 100))%")
                        .foregroundColor(.lairDarkGray).bold()
                }
                ZStack(alignment: .leading) {
                    ZStack {
                        Capsule()
                            .frame(height: 14)
                            .foregroundColor(Color(white: 0.8))
                        LinearGradient.lairHorizontalDarkToLight
                            .frame(height: 14)
                            .mask(Capsule())
                            .opacity(0.7)
                    }
                    ZStack {
                        LinearGradient.lairHorizontalLight
                            .frame(width: (geometry.size.width) * CGFloat(percent), height: 10)
                            .mask(Capsule().padding(.horizontal, 2))
                        LinearGradient.lairVerticalLightToDark
                            .frame(width: (geometry.size.width) * CGFloat(percent), height: 10)
                            .mask(Capsule().padding(.horizontal, 2))
                            .opacity(0.7)
                    }
                    .shadow(color: Color.lairShadowGray.opacity(0.5), radius: 2, x: 0, y: 1)
                }
                .clipShape(Capsule())
            }
            .padding(.horizontal)
        }
    }
}

#Preview("ProgressBar") {
    ProgressBar(percent: .constant(0.42), title: "Laser Charge")
}
