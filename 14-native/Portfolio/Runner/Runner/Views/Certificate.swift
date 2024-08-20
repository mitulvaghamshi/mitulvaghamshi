//
//  ClockCertificate.swift
//  Runner
//
//  Created by Mitul Vaghamshi on 2023-07-06.
//  Copyright © 2023 me.mitul. All rights reserved.
//

import SwiftUI
import Shared

struct Certificate: View {
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Image("Participation Certificate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Flutter Clock Challange")
                    .font(.headline)
                Text("Certificate for Flutter Clock Challenge issued to Mitul Vaghamshi on Jan 21, 2020")
                    .font(.subheadline)
            }
            
            Section("Certificate Issuer") {
                LinkItem(url: ExternalLink.certificate.url, title: nil)
            }
        }
        .navigationTitle("Certificate")
    }
}

#Preview { Certificate() }
