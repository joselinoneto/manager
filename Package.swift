// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "manager",
    platforms: [.iOS(.v15), .macOS(.v12), .watchOS(.v8)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "manager",
            targets: ["manager"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", exact: "5.2.0"),
        .package(path: "../apiclient"),
        .package(path: "../storageclient")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "manager",
            dependencies: [
                "SwifterSwift",
                "apiclient",
                "storageclient"
            ]),
        .testTarget(
            name: "managerTests",
            dependencies: ["manager"]),
    ]
)
