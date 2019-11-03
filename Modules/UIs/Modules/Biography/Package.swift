// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Biography",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "Biography", targets: ["Biography"]),
    ],
    dependencies: [
        .package(path: "../../UIComponents"),
        .package(path: "../../Design"),
        .package(path: "../../../Core"),
        .package(path: "../../../Common"),
    ],
    targets: [
        .target(name: "Biography", dependencies: [
            .product(name: "UIComponents"),
            .product(name: "Design"),
            .product(name: "Core"),
            .product(name: "Common"),
        ], path: "./Sources"),
    ]
)
