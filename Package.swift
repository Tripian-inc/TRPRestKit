// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TRPRestKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "TRPRestKit",
            targets: ["TRPRestKit"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Tripian-inc/TRPFoundationKit",
            branch: "master"
        ),
    ],
    targets: [
        .target(
            name: "TRPRestKit",
            dependencies: [
                .product(name: "TRPFoundationKit", package: "TRPFoundationKit")
            ],
            path: "TRPRestKit"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

