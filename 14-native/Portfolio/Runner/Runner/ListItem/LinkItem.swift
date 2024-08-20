//
//  LinkItem.swift
//  Runner
//
//  Created by Mitul Vaghamshi on 2024-04-25.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct LinkItem: View {
    let url: String
    let title: String?

    var body: some View {
        if let url = URL(string: url) {
            Link(destination: url) {
                if let title = title {
                    Label(title, systemImage: "link")
                } else {
                    Label("\(url.scheme!)://\(url.host!)", systemImage: "link")
                }
            }
            .font(.callout)
        }
    }
}

#Preview { LinkItem(url: "https://apple.com", title: "apple.com") }
