# Registros de diagnóstico — iOS

Habilita los registros al crear la configuración para revisar un problema:

```swift
let config = BDIVConfig(
    clienId: clientId,
    clientSecret: clientSecret,
    contractId: contractId,
    documenTypes: [.DNI, .PASSPORT],
    userId: userId,
    debugLogsEnabled: true
)
verification = BecomeDigitalSDK(bdivConfig: config, delegate: self)
verification?.startVerification()
```

El valor predeterminado es `false`; deshabilita los registros al terminar la revisión. En Xcode o Console, incluye mensajes **Debug** y filtra por `BecomeSDK`.

Para solicitar soporte, incluye la versión de la SDK, el dispositivo, el paso visible y las líneas relevantes de `BecomeSDK`. Revisa los registros antes de compartirlos y excluye credenciales, contenido de licencias, imágenes y datos personales.
