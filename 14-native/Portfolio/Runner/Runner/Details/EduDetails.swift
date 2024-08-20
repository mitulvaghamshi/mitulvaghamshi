//
//  RepoDetails.swift
//  Portfolio
//
//  Created by Mitul Vaghamshi on 2023-06-12.
//  Copyright © 2023 me.mitul. All rights reserved.
//

import SwiftUI
import Shared

struct EduDetails: View {
    let edu: Education

    var body: some View {
        List {
            Image(edu.title)
                .resizable()
                .cornerRadius(4)
                .frame(height: 200)

            EduItem(title: edu.title)

            Section("Education Details") {
                Label("\(edu.year) - (\(edu.duration))", systemImage: "calendar")
                Label(edu.major, systemImage: "graduationcap")
                Label(edu.address, systemImage: "location")
            }
            .font(.callout)

            Section("Website") {
                LinkItem(url: edu.url, title: nil)
            }
        }
        .navigationTitle("Details")
    }
}

#Preview { EduDetails(edu: Education.mohawkcollege) }
