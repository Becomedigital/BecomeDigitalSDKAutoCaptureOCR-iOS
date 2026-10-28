# Continuidad en segundo plano en iOS

Si tu app admite continuar una verificación al pasar a segundo plano, reenvía los eventos del sistema a la SDK desde `AppDelegate`:

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

    // Reenvía el evento a otro componente de la app si le corresponde.
    completionHandler()
}
```

En una app SwiftUI, registra `AppDelegate` mediante `@UIApplicationDelegateAdaptor`. iOS determina cuándo permite continuar el trabajo en segundo plano. Verifica el comportamiento de tu app al cambiar de estado en un dispositivo físico.
