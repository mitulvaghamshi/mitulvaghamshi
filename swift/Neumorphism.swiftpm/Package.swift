// swift-tools-version: 5.9

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Neumorphism",
    platforms: [
        .iOS("17.2")
    ],
    products: [
        .iOSApplication(
            name: "Neumorphism",
            targets: ["AppModule"],
            bundleIdentifier: "me.mitul.neumorphism",
            teamIdentifier: "5H53W9SDBA",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .sparkle),
            accentColor: .presetColor(.teal),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        )
    ]
)