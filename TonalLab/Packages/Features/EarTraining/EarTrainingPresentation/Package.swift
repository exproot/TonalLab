// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EarTrainingPresentation",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "EarTrainingPresentation",
            targets: ["EarTrainingPresentation"]
        ),
    ],
    dependencies: [
      .package(
        name: "SharedUI",
        path: "../../../SharedUI"
      ),
      .package(
        name: "EarTrainingDomain",
        path: "../EarTrainingDomain"
      ),
      .package(
        url: "https://github.com/LottieFiles/dotlottie-ios.git",
        from: "0.13.0"
      )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "EarTrainingPresentation",
            dependencies: [
              .product(
                name: "SharedUI",
                package: "SharedUI"
              ),
              .product(
                name: "EarTrainingDomain",
                package: "EarTrainingDomain"
              ),
              .product(
                name: "DotLottie",
                package: "dotlottie-ios"
              )
            ],
            resources: [
              .process("Resources")
            ]
        ),

    ]
)
