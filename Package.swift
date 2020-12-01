// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hard-spell",
    platforms: [ .macOS(.v10_10) ],
    products: [
        .library(name: "Spelling", targets: [ "Spelling" ]),
        .executable(name: "hard-spell", targets: [ "hard-spell" ])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.3.0"))
    ],
    targets: [
        .target(name: "Spelling"),
        .target(
            name: "Commands",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Spelling"
            ]),
        .target(
            name: "hard-spell",
            dependencies: [
                "Commands"
            ])
    ]
)
