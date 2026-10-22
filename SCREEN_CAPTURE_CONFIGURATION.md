# Protección contra capturas de pantalla — iOS

Esta guía corresponde al XCFramework incluido en este repositorio. El parámetro `BDIVConfig.preventScreenCapture` tiene el valor predeterminado `false` en Debug y Release. En distribuciones anteriores, el valor predeterminado era `true`.

| Valor | Comportamiento de la SDK |
| --- | --- |
| `false` (predeterminado) | La SDK no aplica su protección contra capturas ni la vista de bloqueo por grabación. |
| `true` | La SDK protege sus pantallas y muestra una vista de bloqueo mientras detecta una grabación. |

La opción cubre las pantallas de la SDK; no configura otras pantallas de la app ni modifica protecciones que iOS u otros componentes apliquen por separado.

## Habilitar la protección

```swift
let config = BDIVConfig(
    clienId: "TU_CLIENT_ID",
    clientSecret: "TU_CLIENT_SECRET",
    contractId: "TU_CONTRACT_ID",
    documenTypes: [.DNI, .PASSPORT],
    userId: "TU_USER_ID",
    preventScreenCapture: true
)
let verification = BecomeDigitalSDK(bdivConfig: config, delegate: self)
verification.startVerification()
```

Omite el parámetro o usa `false` para permitir capturas. El valor queda fijo en cada instancia de configuración; crea una nueva si necesitas cambiarlo para un flujo posterior. La opción está disponible en onboarding y autenticación.

## Actualización

Revisa las llamadas que antes omitían el parámetro. Pasa `true` donde deba mantenerse la protección. Los valores explícitos conservan el comportamiento solicitado. Recompila la app con el framework y las dependencias indicadas en el [README](README.md).

En un dispositivo físico, verifica las capturas y la grabación durante la captura documental, la validación facial, la cancelación y el regreso a la app. Prueba ambos valores si la app admite los dos modos.
