//
//  OneCardApp.swift
//  OneCard
//
//  Created by Mitul Vaghamshi on 2022-11-20.
//

import SwiftUI

struct MohawkId: View {
    var body: some View {
        List {
            ZStack(alignment: .top) {
                background()
                foreground()
            }
            .background(.white)
            .cornerRadius(8)
            .drawingGroup()
            .shadow(color: .primary, radius: 8)
        }
        .listStyle(.plain)
        .navigationTitle("Student ID")
    }
}

private extension MohawkId {
    @ViewBuilder private func background() -> some View {
        VStack(spacing: 0) {
            Color.black
                .frame(height: 200)
            Group {
                Color("Color3")
                Color("Color2")
                Color("Color1")
            }
            .frame(height: 5)
            Spacer(minLength: 260)
            Image("Bottom Border")
                .resizable()
                .frame(height: 100)
        }
    }

    @ViewBuilder private func foreground() -> some View {
        VStack(spacing: 0) {
            Image("Mohawk Title")
                .padding(20)

            Image("Mitul")
                .resizable()
                .frame(width: 210, height: 270)
                .border(Color("Color1"), width: 5)
                .background(.gray)
                .padding(.bottom, 8)

            HStack {
                VStack {
                    HStack(spacing: 0) {
                        Text("O").foregroundColor(Color("Color1"))
                        Text("N").foregroundColor(Color("Color2"))
                        Text("E").foregroundColor(Color("Color3"))
                    }
                    .font(.system(size: 36, weight: .bold))
                    Text("CARD")
                        .font(.system(size: 20, design: .monospaced))
                }

                Image(systemName: "wave.3.forward")
                    .font(.system(size: 36, weight: .semibold))
            }
            .padding(.leading, 30)

            Text("Mitul Vaghamshi")
                .font(.system(size: 36, weight: .semibold, design: .rounded))

            Text("000821600")
                .font(.system(size: 26, weight: .regular, design: .rounded))
        }
        .foregroundColor(.black)
    }
}

#Preview { MohawkId() }
