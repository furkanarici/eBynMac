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
                .product(name: "Sparkle", package: "Sparkle", condition: .when(platforms: [.macOS]))
            ],
            path: "Sources/eBeyanname",
            resources: [
                .process("Resources")
            ],
            linkerSettings: [
                // Embeds Info.plist into the binary so NSBundle/CFBundle
                // and Sparkle can read CFBundleIdentifier, CFBundleVersion, etc.
                .unsafeFlags([
                    "-Xlinker", "-sectcreate",
                    "-Xlinker", "__TEXT",
                    "-Xlinker", "__info_plist",
                    "-Xlinker", "Sources/eBeyanname/Info.plist"
                ])
            ]
        )
    ]
)
