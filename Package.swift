// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-tca-custom-alert",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9)
        /// This method of presentation for WatchOS is possible but not recomended.
        /// For Alerts, we recomend the SwiftUI standard library alert.
    ],
    products: [
        .library(
            name: "TCACustomAlert",targets: ["TCACustomAlert"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "0.47.2"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.9.0"
        )
    ],
    targets: [
        .target(
            name: "TCACustomAlert",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "TCACustomAlertTests",
            dependencies: [
                "TCACustomAlert",
            ]
        ),
        .testTarget(
            name: "AlertSnapshots",
            dependencies: [
                "TCACustomAlert",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            exclude: [
                "__Snapshots__"
            ]
        )
    ]
)
