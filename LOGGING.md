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

## Diagnóstico de validación facial

Con los registros habilitados, la SDK permite distinguir la evaluación del puntaje facial, el resultado de la validación adicional de la selfie y el motivo por el que se solicita repetir la captura.

| Evento | Interpretación |
| --- | --- |
| `confidence_evaluated` | Compara el puntaje recibido con el mínimo configurado. |
| `selfie_validation_result` | Distingue una validación aceptada, rechazada o no disponible. |
| `selfie_feedback_presented` | Identifica el motivo del mensaje de reintento. |

Una evaluación de confianza aceptada no equivale a la aprobación final del proceso. Usa los callbacks públicos para determinar el resultado de la verificación. Al solicitar soporte, conserva la secuencia del intento y el motivo del reintento.

Los registros utilizan categorías y campos acotados. La SDK no incluye cuerpos completos de respuestas, imágenes, tokens ni credenciales en estos diagnósticos. El diagnóstico continúa deshabilitado de forma predeterminada y se habilita desde la configuración de la app.
