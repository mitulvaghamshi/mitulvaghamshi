//
//  EduListItem.swift
//  Runner
//
//  Created by Mitul Vaghamshi on 2023-07-06.
//  Copyright © 2023 me.mitul. All rights reserved.
//

import SwiftUI

struct EduItem: View {
    let title: String
    
    var body: some View {
        HStack {
            Image("\(title) Logo")
                .resizable()
                .cornerRadius(4)
                .frame(width: 40, height: 40)
            Text(title)
        }
    }
}

#Preview { EduItem(title: "Mohawk College") }
