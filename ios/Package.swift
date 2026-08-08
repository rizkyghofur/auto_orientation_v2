// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "auto_orientation_v2",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "auto_orientation_v2",
            targets: ["auto_orientation_v2"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "auto_orientation_v2",
            dependencies: [],
            resources: []
        )
    ]
)
