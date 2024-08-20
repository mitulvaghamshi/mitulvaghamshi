//
//  Accessory.swift
//  Neumorphic
//
//  Created by Mitul Vaghamshi on 2025-02-16.
//

import Foundation

struct Accessory: Identifiable {
    let id: UUID = UUID()
    let title: String
    let image: String
}

extension Accessory {
    static func items() -> [Accessory] {[
        Accessory(title: "Apple Inc.", image: "apple.logo"),
        Accessory(title: "Dungeon", image: "lock.shield"),
        Accessory(title: "Evil Music", image: "music.house"),
        Accessory(title: "Periscope", image: "eye"),
        Accessory(title: "Death Ray", image: "scope"),
    ]}
}
