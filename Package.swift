// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AFNavigationKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "AFNavigationKit",
            targets: ["AFNavigationKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "AFNavigationKit"),
        .testTarget(
            name: "AFNavigationKitTests",
            dependencies: ["AFNavigationKit"]),
    ]
)
