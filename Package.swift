// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPiGpio",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftPiGpio",
            targets: ["SwiftPiGpio"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/devwaseem/SwiftPiGpioLib", Version(0,0,1)..<Version(1,0,0)),
        // .package(path: "../SwiftPiGpioLib"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftPiGpio",
            dependencies: []),
        .testTarget(
            name: "SwiftPiGpioTests",
            dependencies: ["SwiftPiGpio"]),
    ]
)
