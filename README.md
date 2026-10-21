# BecomeDigital SDK AutoCapture OCR — iOS

Native identity verification with automatic document capture, OCR-assisted recognition, a manual capture fallback, and facial verification. This repository distributes `BDIdentityVerification.xcframework` and integration documentation for client applications.

## Features

- Onboarding and authentication with typed results.
- Automatic document scanning with framing, image-quality feedback, and front/back guidance.
- Manual capture after 30 seconds by default when automatic scanning has not completed, with document recognition and retry support.
- SwiftUI screens, searchable country selection, and contract-assigned branding and text.
- Host-selected light, dark, or system appearance and optional screen-capture protection.

## Requirements and dependencies

| Component | Required version |
| --- | --- |
| iOS | 16.0 or later |
| Become SDK framework version | 1.2.3 |
| Amplify Swift | 2.53.3 |
| Amplify UI Swift Liveness | 1.4.4 |
| BlinkID iOS package | 8002.0.2 |
| Xcode toolchain | Swift 6 compatible |

The XCFramework includes iOS device arm64 and iOS Simulator arm64/x86_64 slices. It is a binary distribution; adding this repository as a Swift package is not supported.

## Installation

1. Download or clone this repository and add `BDIdentityVerification.xcframework` to the application target.
2. In **Frameworks, Libraries, and Embedded Content**, select **Embed & Sign**.
3. Add these packages with **Exact Version** in Xcode:

| Package URL | Version |
| --- | --- |
| `https://github.com/aws-amplify/amplify-swift` | 2.53.3 |
| `https://github.com/aws-amplify/amplify-ui-swift-liveness` | 1.4.4 |
| `https://github.com/microblink/blinkid-ios` | 8002.0.2 |

Add the required Amplify and Face Liveness products to the application target. Add the **BlinkIDUX** product; its package also supplies the **BlinkID** binary dependency. Verify the final application's `Frameworks` directory contains **BDIdentityVerification.framework**, **BlinkID.framework**, and **BlinkIDUX.framework**, embedded and signed.

When upgrading from the earlier Capture integration, remove its Capture Core/UX package references and embedded frameworks. The Swift module remains `BDIdentityVerification`; the repository name does not change the public API.

### Application license

Obtain a BlinkID Core license from BecomeDigital for the application's **Bundle Identifier**. Add it as `com.become.blinkid.key.txt` to the app target and **Copy Bundle Resources**. License contents and application credentials are not included in this repository. A different Bundle Identifier, including a development variant, requires a matching license.

### Permissions

Add the camera usage description to the application's `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required to verify your identity.</string>
```

If the application uses location, also provide `NSLocationWhenInUseUsageDescription`.

## Start verification

The delegate must be a `UIViewController` implementing `BDIVDelegate`. Retain the SDK instance throughout the flow.

```swift
import UIKit
import BDIdentityVerification

final class VerificationViewController: UIViewController, BDIVDelegate {
    private var verification: BecomeDigitalSDK?

    func startOnboarding() {
        let config = BDIVConfig(
            clienId: "YOUR_CLIENT_ID",
            clientSecret: "YOUR_CLIENT_SECRET",
            contractId: "YOUR_CONTRACT_ID",
            documenTypes: [.DNI, .PASSPORT],
            userId: "YOUR_USER_ID",
            flow: .Onboarding,
            themeMode: .system
        )
        verification = BecomeDigitalSDK(bdivConfig: config, delegate: self)
        verification?.startVerification()
    }

    func BDIVResponseSuccess(bdivResult: BDIdentityVerificationResponse) {
        guard bdivResult.responseStatus == .SUCCES else { return }
        if let started = bdivResult.onboarding { _ = started.userId }
        if let completed = bdivResult.verification { _ = completed.urlGetData }
        if let authentication = bdivResult.authentication {
            // Evaluate the authentication decision separately from callback success.
            _ = authentication.result
        }
    }

    func BDIVResponseError(error: String) {
        // Restore the host UI and offer a user-initiated restart.
    }
}
```

The existing spellings `clienId`, `documenTypes`, and `SUCCES` are retained for compatibility. For authentication, use `flow: .Authentication`; `documenTypes: []` is supported when document capture is not required.

## Public configuration

| Parameter | Default | Purpose |
| --- | --- | --- |
| `clienId`, `clientSecret`, `contractId`, `userId` | Required | Identify the client, contract, and user. |
| `documenTypes` | Required for onboarding | `.DNI`, `.PASSPORT`, `.DRIVERLICENSE`; authentication may use `[]`. |
| `flow` | `.Onboarding` | `.Onboarding` or `.Authentication`. |
| `performVerificationCheck` | `true` | Wait for the final onboarding result. |
| `pollingMaxAttempts` | `0` | Maximum result checks; `0` has no attempt limit. |
| `pollingTimeout` | 2 seconds | Timeout for each result check, not for the whole flow. |
| `debugLogsEnabled` | `false` | Opt in to diagnostic logs during an investigation. |
| `preventScreenCapture` | `false` | Enable SDK screen-capture protection. |
| `country`, `state` | `nil` | Prefilled two-letter country code and US state, when applicable. |
| `nationalIdType`, `nationalIdTypeChoices`, `documentNumber` | Empty | Optional prefilled document details. |
| `themeMode` | `.system` | `.light`, `.dark`, or `.system`. |

The SDK presents the steps, colors, logo, layout, and text assigned to the contract. Design overrides are not part of `BDIVConfig`. Override individual phrases using the host application's `Localizable.strings`; see [localization](LOCALIZACION.md).

The initial animated loader remains visible until the flow and its presentation are ready. It starts with the host application's `AccentColor` or inherited tint and a localized loading message. The first visible step already uses the configured appearance. Initialization failures use the existing error callback.

If a result check needs more time, pass a larger `pollingTimeout`, for example `30`. This is independent of the manual capture fallback's default 30-second delay.

## Typed responses

`BDIVResponseSuccess` supplies `BDIdentityVerificationResponse` with `responseStatus`, `message`, and optional result objects:

| Object | Public fields | Meaning |
| --- | --- | --- |
| `onboarding` | `code`, `message`, `urlResource`, `userId` | Creation acknowledged when `performVerificationCheck=false`; this is not a final approval. |
| `verification` | `urlGetData` | Final onboarding result when result checking is enabled. |
| `authentication` | `company`, `confidence`, `executionId`, `liveness`, `result`, `userId` | Authentication details; evaluate `result` separately. |

Unwrap only the result appropriate to the flow. Errors and cancellation use `BDIVResponseError(error:)`; see [error handling](ERRORES.md). Use the concrete result objects instead of dictionary-based response access.

## Integration guides

- [Error handling](ERRORES.md)
- [Localization and text overrides](LOCALIZACION.md) and [resource template](Localizable.strings)
- [Diagnostic logging](LOGGING.md)
- [Screen-capture protection](SCREEN_CAPTURE_CONFIGURATION.md)
- [Background events](CARGAS_SEGUNDO_PLANO.md)
- [Artifact checksums](CHECKSUMS.sha256)

Before releasing the host app, test automatic/manual document capture, retry, permissions, facial verification, callbacks, and cancellation on a physical device using its licensed application identifier.
