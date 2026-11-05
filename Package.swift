// swift-tools-version: 6.4
import PackageDescription

// Versión y checksum del artefacto de esta distribución.
let artifactVersion = "3.5.1"
let artifactChecksum = "24864b0ee8184c5d4e76d46b9a1b0e9e2672ab8a099039432f636ecb0b6a8ef2"
let artifactURL = "https://github.com/Becomedigital/BecomeDigitalSDKAutoCaptureOCR-iOS/releases/download/\(artifactVersion)/BDIdentityVerification-\(artifactVersion).xcframework.zip"

let package = Package(
    name: "BecomeDigitalSDKAutoCaptureOCR",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BDIdentityVerification",
            targets: ["BDIdentityVerification", "BecomePackageDependencies"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/microblink/blinkid-ios.git", exact: "8002.0.2"),
        .package(url: "https://github.com/aws-amplify/amplify-ui-swift-liveness", exact: "1.4.4"),
        .package(url: "https://github.com/aws-amplify/amplify-swift", exact: "2.53.3")
    ],
    targets: [
        .binaryTarget(
            name: "BDIdentityVerification",
            url: artifactURL,
            checksum: artifactChecksum
        ),
        .target(
            name: "BecomePackageDependencies",
            dependencies: [
                "BDIdentityVerification",
                .product(name: "BlinkIDUX", package: "blinkid-ios"),
                .product(name: "FaceLiveness", package: "amplify-ui-swift-liveness"),
                .product(name: "Amplify", package: "amplify-swift")
            ]
        )
    ]
)
