import SwiftUI

@MainActor class ViewModel: ObservableObject {
    @Published var state: DataState = .loading

    func fetch() {
        Task {
            do {
                state = .loading
                let items = try await fetch()
                state = .data(items)
            } catch {
                state = .error("Unable to fetch affirmation.")
            }
        }
    }
}

extension ViewModel {
    enum DataState {
        case loading
        case error(String)
        case data([DataItem])
    }

    struct DataItem: Identifiable {
        let id: Int
        let text: String
        let image: String
    }
}

extension ViewModel {
    private func fetch() async throws -> [DataItem] {
        try await delay(seconds: 2) // 2 seconds delay.
        return (1...affirmations_text.count).map { i in
            DataItem(id: i, text: affirmations_text[i-1], image: "image\(i)")
        }
    }

    private func delay(seconds: UInt64) async throws {
        try await Task.sleep(nanoseconds: seconds * 1_000_000_000)
    }
}
