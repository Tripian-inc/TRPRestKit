// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TRPRestKit",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "TRPRestKit",
            targets: ["TRPRestKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Tripian-inc/TRPFoundationKit.git", branch: "feature/spm")
    ],
    targets: [
        .target(
            name: "TRPRestKit",
            dependencies: [
                .product(
                    name: "TRPFoundationKit",
                    package: "TRPFoundationKit"
                    )
                ],
            path: "TRPRestKit"),
        /*.testTarget(
            name: "TRPRestKitiOS.Tests",
            dependencies: ["TRPRestKit"],
            path: "TRPRestKitiOS.Tests"), */
    ]
)
