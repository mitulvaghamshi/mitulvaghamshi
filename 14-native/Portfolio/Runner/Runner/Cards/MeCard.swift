//
//  IntroCard.swift
//  Runner
//
//  Created by Mitul Vaghamshi on 2023-06-15.
//  Copyright © 2023 me.mitul. All rights reserved.
//

import SwiftUI
import Shared

struct MeCard: View {
    var body: some View {
        NavigationView {
            List {
                Image("Me")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding(.top, 10)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Software Developer")
                        .opacity(0.5)
                    Text("Mitul Vaghamshi_")
                        .font(.largeTitle)
                }

                Section("Social Connect") {
                    HStack(alignment: .center) {
                        ForEach(SocialLink.entries) { link in
                            Link(destination: URL(string: link.url)!) {
                                Image(link.name)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .padding(8)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }

                Section("Introduction") {
                    Text(DataKt.DESCRIPTION)
                        .font(.subheadline)
                }

                Section("External Links") {
                    ForEach(ExternalLink.entries.dropLast(4)) { link in
                        LinkItem(url: link.url, title: link.title)
                    }
                }

                Section("About") {
                    let copyright = ExternalLink.copyright
                    Link(destination: URL(string: copyright.url)!) {
                        HStack(alignment: .center, spacing: 10) {
                            Image("Flutter Dash")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text(copyright.title)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .navigationTitle("Its Me")
        }
    }
}

extension ExternalLink: @retroactive Identifiable {}

extension SocialLink: @retroactive Identifiable {}

#Preview { MeCard() }
