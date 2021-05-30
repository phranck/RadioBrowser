// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadioBrowser",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "RadioBrowser",
            targets: ["RadioBrowser"]),
    ],
    dependencies: [
        .package(name: "SwiftyBeaver", url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.9.5"),
    ],
    targets: [
        .target(
            name: "RadioBrowser",
            dependencies: [
                "SwiftyBeaver"
            ],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
