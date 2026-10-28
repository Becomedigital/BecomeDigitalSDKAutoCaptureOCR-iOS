# iOS integration demo

This app shows how to start identity verification from a SwiftUI screen and receive results in a UIKit controller that implements `BDIVDelegate`. It uses `BDIdentityVerification.xcframework` from the root of this distribution. The Xcode project pins its package dependencies.

## Prepare the demo

1. Open [iOSBlinkIDIntegration.xcodeproj](iOSBlinkIDIntegration.xcodeproj) in Xcode and select the `iOSBlinkIDIntegration` target.
2. Select your signing team and replace `PRODUCT_BUNDLE_IDENTIFIER` with the app identifier covered by your BlinkID license. `com.example.become.integration` is a placeholder.
3. Copy `App/DemoConfiguration.example.plist` to `App/DemoConfiguration.plist`. Fill in `clientId`, `clientSecret`, and `contractId` with the values assigned to your contract. The example enables `debugLogsEnabled` for manual testing; disable it for a production app.
4. Save the BlinkID license assigned to that app identifier as `App/com.become.blinkid.key.txt`.
5. Build and run the app on a physical device running iOS 16 or later. Enter a user ID and tap **Start onboarding**.

Contact BecomeDigital to obtain credentials, a contract ID, and a license for your app. They are not included in this demo. When configuration or license is missing, the app displays a message and does not start verification. Both local files are ignored by Git and copied into the app only during a local build. Do not distribute a build containing test credentials.

## Project map

- `VerificationScreen.swift` defines the SwiftUI screen and passes the user ID to the controller.
- `ViewController.swift` presents that screen with `UIHostingController`, creates `BDIVConfig`, retains the SDK instance, and handles `BDIVResponseSuccess` and `BDIVResponseError`.
- `AppDelegate.swift` forwards background session events to the SDK. `SceneDelegate.swift` creates the window for the UIKit scene lifecycle.
- `Info.plist` declares camera and location permissions and the scene configuration. The `Localizable.strings` files demonstrate Spanish localization for the SDK and the host app.
- `generate_project.rb` regenerates the Xcode project when its structure changes. It requires the Ruby `xcodeproj` gem.

See the [installation guide](../../INSTALACION.md), [localization guide](../../LOCALIZACION.md), [logging guide](../../LOGGING.md), and [error handling guide](../../ERRORES.md) when adapting this integration to your app.
