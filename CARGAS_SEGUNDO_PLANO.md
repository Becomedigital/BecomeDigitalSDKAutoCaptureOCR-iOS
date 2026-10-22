# Eventos en segundo plano — iOS

Si la app admite continuar una verificación en segundo plano, reenvía los eventos del sistema desde `AppDelegate`:

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

    // Reenvía el evento al componente de la app que tenga a cargo la sesión.
    completionHandler()
}
```

En una app SwiftUI, registra `AppDelegate` mediante `@UIApplicationDelegateAdaptor`. iOS determina cuándo puede continuar el trabajo en segundo plano. Prueba el comportamiento de la app durante los cambios de estado en un dispositivo físico antes de publicarla.
