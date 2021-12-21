// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cron-parser",
    dependencies: [],
    targets: [
        .executableTarget(name: "cron-parser", dependencies: []),
        .testTarget(name: "cron-parserTests", dependencies: ["cron-parser"]),
    ]
)
