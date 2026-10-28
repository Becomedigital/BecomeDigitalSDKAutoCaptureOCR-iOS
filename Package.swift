// swift-tools-version: 5.9
import PackageDescription

// Regenerate these values from the final XCFramework with
// `python3 scripts/prepare_spm_release.py` before tagging a release.
let artifactVersion = "1.2.3"
let artifactChecksum = "d4b9f3f28b755547f03be5ffe4510396752deb98c57a7725e144d7e58be27e1b"
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
        .package(url: "https://github.com/aws-amplify/amplify-ui-swift-liveness", from: "1.4.5"),
        .package(url: "https://github.com/aws-amplify/amplify-swift", from: "2.58.5")
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
