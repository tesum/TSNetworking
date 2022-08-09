// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkingExample",
    platforms: [
      .iOS(.v11),
      .macOS(.v10_12),
      .tvOS(.v10),
      .watchOS(.v5)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NetworkingExample",
            type: .dynamic,
            targets: ["NetworkingExample"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1")),
      .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NetworkingExample",
            dependencies: [
              .product(name: "Alamofire", package: "Alamofire"),
              "Swinject"
            ]),
        .testTarget(
            name: "NetworkingExampleTests",
            dependencies: ["NetworkingExample"]),
    ]
)
