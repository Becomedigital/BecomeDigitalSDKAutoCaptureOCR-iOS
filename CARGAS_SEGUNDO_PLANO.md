# Background events — iOS

If the host app supports continuing verification in the background, forward system events from `AppDelegate`:

```swift
import UIKit
import BDIdentityVerification

func application(_ application: UIApplication,
                 handleEventsForBackgroundURLSession identifier: String,
                 completionHandler: @escaping () -> Void) {
    if BecomeDigitalSDK.handleEventsForBackgroundURLSession(
        identifier, completionHandler: completionHandler
    ) {
        return
    }

    // Forward the event to another host component if it owns the session.
    completionHandler()
}
```

In a SwiftUI application, register `AppDelegate` using `@UIApplicationDelegateAdaptor`. iOS determines when background work may continue. Test the host's lifecycle behavior on a physical device before release.
