// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "eBeyanname",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "eBeyanname",
            dependencies: [
                .product(name: "Sparkle", package: "Sparkle")
            ],
            path: "Sources/eBeyanname",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
