// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Burritos",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Burritos",
            targets: ["Lazy", "UserDefault"]),
    ],
    dependencies: [], // No dependencies
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "Lazy", dependencies: []),
        .testTarget(name: "LazyTests", dependencies: ["Lazy"]),
        .target(name: "UserDefault", dependencies: []),
        .testTarget(name: "UserDefaultTests", dependencies: ["UserDefault"]),
    ]
)
