//
//  Data.swift
//  NuemorphicDesign
//
//  Created by Mitul Vaghamshi on 2022-11-20.
//

import SwiftUI

class Data {
    static let accessories: [AccessoryItem] = [
        AccessoryItem(title: "Apple Inc.", image: Image(systemName: "apple.logo")),
        AccessoryItem(title: "Dungeon", image: Image(systemName: "lock.shield")),
        AccessoryItem(title: "Evil Music", image: Image(systemName: "music.house")),
        AccessoryItem(title: "Periscope", image: Image(systemName: "eye")),
        AccessoryItem(title: "Death Ray", image: Image(systemName: "scope")),
    ]
    
    static let tabBarItems: [TabBarItem] = [
        TabBarItem(
            selectedItem: .constant(.lair),
            smartView: .lair,
            icon: "pencil.tip"),
        TabBarItem(
            selectedItem: .constant(.lair),
            smartView: .camera,
            icon: "video.circle"),
        TabBarItem(
            selectedItem: .constant(.lair),
            smartView: .settings,
            icon: "gear")
    ]
}
