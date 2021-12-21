// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Argon",
	platforms: [
		.iOS(.v15), .macOS(.v11)
	],
    products: [
        .library(name: "Argon", targets: ["Argon"]),
		.library(name: "ArgonServer", targets: ["ArgonServer"]),
    ],
    dependencies: [
		.package(name: "SerializedSwift", url: "https://github.com/dejanskledar/SerializedSwift", branch: "master"),
		.package(name: "PublishedObject", url: "https://github.com/Amzd/PublishedObject", from: "0.2.0"),
		
		.package(name: "swift-nio", url: "https://github.com/apple/swift-nio", .upToNextMinor(from: "2.34.0")),
		.package(name: "vapor", url: "https://github.com/vapor/vapor", from: "4.50.0"),
		.package(name: "fluent", url: "https://github.com/vapor/fluent", from: "4.4.0"),
		.package(name: "fluent-postgres-driver", url: "https://github.com/vapor/fluent-postgres-driver", from: "2.2.0"),
    ],
    targets: [
        .target(name: "Argon", dependencies: [
			"SerializedSwift",
			"PublishedObject" ]),
		
		.target(name: "ArgonServer", dependencies: [
			"Argon",
			.product(name: "Vapor", package: "vapor"),
			.product(name: "Fluent", package: "fluent"),
			.product(name: "FluentPostgresDriver", package: "fluent-postgres-driver") ]),
        
		.testTarget(name: "ArgonTests", dependencies: ["Argon"]),
    ]
)
