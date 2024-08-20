import PlaygroundSupport
import SwiftUI

let message = "Hello World!"

print(message)

let body: some View = VStack {
    List(1..<20) { item in
        Label(message, systemImage: "\(item).circle")
    }
}

PlaygroundPage.current.setLiveView(body)
