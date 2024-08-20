import SwiftUI

struct AccessoryItem: View {
    let accessory: Accessory

    var body: some View {
        VStack {
            LinearGradient.lairHorizontalDark
                .mask(Image(systemName: accessory.image).resizable().scaledToFit())
                .frame(width: 150, height: 180)
                .padding(30)
                .font(.system(size: 150, weight: .thin))
                .shadow(color: .white, radius: 2, x: -3, y: -3)
                .shadow(color: .lairShadowGray, radius: 2, x: 3, y: 3)
            HStack {
                    Text(accessory.title)
                    .bold()
                    .foregroundColor(.lairDarkGray)
                    .padding(.leading)
                    .padding(.bottom)
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .frame(width: 230)
        .background(Color.lairBackgroundGray)
        .cornerRadius(15)
        .shadow(color: Color(white: 1.0).opacity(0.9), radius: 18, x: -18, y: -18)
        .shadow(color: Color.lairShadowGray.opacity(0.5), radius: 14, x: 14, y: 14)
    }
}

#Preview("AccessoryItem") {
    AccessoryItem(accessory: Accessory(title: "Control Room", image: "lock.shield"))
}
