// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Burritos",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Burritos",
            targets: [
                "Copying",
                "LateInit",
                "Lazy",
                "UserDefault",
            ]),
    ],
    dependencies: [], // No dependencies
    targets: [
        // Template to add a new propert wrapped called {Wrap}:
        // .target(name: "{Wrap}", dependencies: []),
        // .testTarget(name: "{Wrap}Tests", dependencies: ["{Wrap}"]),
        //
        // Please add the target in alphabetical order.
        // Also add "{Wrap}" to the products library targets list.
        .target(name: "Copying", dependencies: []),
        .testTarget(name: "CopyingTests", dependencies: ["Copying"]),
        .target(name: "LateInit", dependencies: []),
        .testTarget(name: "LateInitTests", dependencies: ["LateInit"]),
        .target(name: "Lazy", dependencies: []),
        .testTarget(name: "LazyTests", dependencies: ["Lazy"]),
        .target(name: "UserDefault", dependencies: []),
        .testTarget(name: "UserDefaultTests", dependencies: ["UserDefault"]),
    ]
)
