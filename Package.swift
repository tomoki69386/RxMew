// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxMew",
    products: [
        .library(
            name: "RxMew",
            targets: ["RxMew"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tomoki69386/Mew", from: "0.3.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "5.1.1")
    ],
    targets: [
        .target(
            name: "RxMew",
            dependencies: []),
        .testTarget(
            name: "RxMewTests",
            dependencies: ["RxMew"]),
    ]
)
