//
//  WesDetails.swift
//  Runner
//
//  Created by Mitul Vaghamshi on 2023-07-06.
//  Copyright © 2023 me.mitul. All rights reserved.
//

import SwiftUI
import Shared

struct WesEval: View {
    var body: some View {
        List {
            Section(header: Text("Varification Badge")) {
                Image("Degree Evaluation Logo")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)

                HStack {
                    Spacer()
                    Text("Verified International Academic Qualifications")
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }

            Group {
                let wesEval = ExternalLink.weseval
                Section(wesEval.title) {
                    LinkItem(url: wesEval.url, title: nil)
                }

                let wesReport = ExternalLink.wesreport
                Section(wesReport.title) {
                    LinkItem(url: wesReport.url, title: nil)
                }
            }
        }
        .navigationTitle("Degree Evaluation")
    }
}

#Preview { WesEval() }
