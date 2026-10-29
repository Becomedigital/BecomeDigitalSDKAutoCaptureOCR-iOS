# Protección contra capturas de pantalla en iOS

Configura `preventScreenCapture` antes de iniciar la verificación, según los requisitos de privacidad de tu app.

| Valor | Comportamiento |
| --- | --- |
| `false`, predeterminado | La SDK permite capturas y grabaciones de sus pantallas. |
| `true` | La SDK activa la protección de sus pantallas contra capturas y grabaciones. |

La opción está disponible en onboarding y autenticación. Se aplica a las pantallas de BecomeDigital; no cambia la protección de otras pantallas de tu app ni las restricciones independientes del sistema u otros componentes.

## Habilitar la protección

```swift
let config = BDIVConfig(
    jwt: jwt,
    contractId: contractId,
    documenTypes: [.DNI, .PASSPORT],
    userId: userId,
    preventScreenCapture: true
)
```

Crea una nueva instancia de `BDIVConfig` si otra verificación necesita un valor diferente.

## Actualizar una integración anterior

En entregas anteriores, la protección estaba habilitada de forma predeterminada. Si tu app necesita conservarla, establece `true` explícitamente. Los valores `true` o `false` ya indicados conservan el comportamiento solicitado.

Después de actualizar la app, comprueba las capturas y la grabación en un dispositivo físico durante la captura del documento, la validación facial, la cancelación y el regreso a la app.
