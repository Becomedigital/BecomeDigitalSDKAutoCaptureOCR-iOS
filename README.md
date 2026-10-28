# SDK de BecomeDigital AutoCapture OCR para iOS

Integra la verificación de identidad en tu aplicación: onboarding, autenticación, captura documental automática, reconocimiento OCR y alternativa manual y validación facial. Esta distribución incluye `BDIdentityVerification.xcframework` y utiliza BlinkID para la captura de documentos.

## Antes de comenzar

- Usa iOS 16.0 o posterior y Xcode compatible con Swift 6.4.
- Solicita las credenciales de tu integración, el identificador del contrato y la licencia para el identificador de tu app.
- Sigue la [guía de instalación](INSTALACION.md) para agregar el archivo de la SDK, sus dependencias y los permisos necesarios.
- Revisa el [demo de integración para iOS](Demo/iOSBlinkIDIntegration/README.md) para ver un ejemplo completo con SwiftUI y UIKit.
- Realiza las pruebas de cámara, documento y validación facial en un dispositivo físico.

Esta entrega corresponde a producción. La configuración de compilación de tu app no cambia ese ambiente. Si necesitas otra entrega, solicítala a BecomeDigital con una licencia válida para el identificador de esa aplicación.

## Iniciar una verificación

El delegado debe ser un `UIViewController` que implemente `BDIVDelegate`. Conserva la instancia de la SDK mientras la verificación esté activa.

```swift
import UIKit
import BDIdentityVerification

final class VerificationViewController: UIViewController, BDIVDelegate {
    private var verification: BecomeDigitalSDK?

    func startOnboarding() {
        let config = BDIVConfig(
            clienId: "TU_CLIENT_ID",
            clientSecret: "TU_CLIENT_SECRET",
            contractId: "TU_CONTRACT_ID",
            documenTypes: [.DNI, .PASSPORT],
            userId: "TU_USER_ID",
            flow: .Onboarding,
            themeMode: .system
        )
        verification = BecomeDigitalSDK(bdivConfig: config, delegate: self)
        verification?.startVerification()
    }

    func BDIVResponseSuccess(bdivResult: BDIdentityVerificationResponse) {
        guard bdivResult.responseStatus == .SUCCES else { return }
        if let started = bdivResult.onboarding {
            // El proceso fue creado; esto no confirma su aprobación final.
            _ = started.userId
        }
        if let completed = bdivResult.verification {
            // Consulta el resultado de onboarding.
            _ = completed.urlGetData
        }
        if let authentication = bdivResult.authentication {
            // Evalúa la decisión de autenticación por separado.
            _ = authentication.result
        }
    }

    func BDIVResponseError(error: String) {
        // Regresa a la app y permite un nuevo intento iniciado por el usuario.
    }
}
```

Los nombres `clienId`, `documenTypes` y `SUCCES` corresponden a la API pública y deben escribirse así.

### Autenticación de un usuario existente

Usa `flow: .Authentication` con un `userId` existente. Cuando no se soliciten documentos, puedes pasar `documenTypes: []`.

## Configurar la integración

| Parámetro | Valor predeterminado | Uso |
| --- | --- | --- |
| `clienId`, `clientSecret`, `contractId` | Argumentos requeridos | Credenciales e identificador del contrato asignados a tu integración; no deben estar vacíos. |
| `userId` | Argumento requerido | Identificador del usuario. Debe estar informado en autenticación; onboarding también admite una cadena vacía. |
| `documenTypes` | Argumento requerido | Tipos de documento: `.DNI`, `.PASSPORT`, `.DRIVERLICENSE`. Una lista vacía utiliza los tipos disponibles para el contrato. |
| `flow` | `.Onboarding` | Selecciona onboarding o autenticación. |
| `performVerificationCheck` | `true` | Espera el resultado final de onboarding. Con `false`, entrega la confirmación de creación del proceso. |
| `pollingMaxAttempts` | `0` | Máximo de consultas del resultado. Con `0`, la espera no tiene límite de intentos. |
| `pollingTimeout` | 2 segundos | Tiempo máximo de cada consulta del resultado; no es la duración máxima de toda la verificación. |
| `debugLogsEnabled` | `false` | Activa registros de diagnóstico para revisar un problema con soporte. |
| `preventScreenCapture` | `false` | Activa la protección de las pantallas de la SDK contra capturas y grabaciones. |
| `country`, `state` | `nil` | País de dos letras o lista de países separados por comas; estado de EE. UU., cuando corresponda. |
| `nationalIdType`, `documentNumber` | `nil` | Datos opcionales del documento precargados. |
| `nationalIdTypeChoices` | Lista vacía | Opciones de subtipo documental, cuando correspondan al contrato. |
| `themeMode` | `.system` | Modo claro (`light`), oscuro (`dark`) o preferencia del dispositivo (`system`). |

Crea otra instancia de `BDIVConfig` para cambiar sus valores en una verificación posterior.

Si necesitas limitar la espera del resultado final, asigna un `pollingMaxAttempts` mayor que cero y maneja el callback de error. Un valor mayor en `pollingTimeout`, por ejemplo `30`, concede más tiempo a cada consulta individual.

## Apariencia, documentos e idioma

El contrato define los pasos disponibles, la apariencia, el logo y los textos del recorrido. La app elige el modo claro, oscuro o del sistema mediante `themeMode`. `BDIVConfig` no modifica los colores, el logo ni los textos del recorrido.

La lista de documentos de la app se combina con los tipos disponibles para el contrato. Si no hay coincidencias, se utiliza la lista del contrato. Un único tipo de documento también se presenta para confirmación. La SDK solicita los lados requeridos para cada documento; los flujos que solo piden documentos no requieren una captura facial.

La pantalla de carga permanece visible hasta que el primer paso está listo. Su color inicial toma el color de énfasis de la app (`AccentColor` o el tinte heredado).

La alternativa de captura manual se habilita, de forma predeterminada, después de 30 segundos sin completar la autocaptura. Este tiempo es independiente de la consulta del resultado final.

Los textos asignados al contrato se aplican sin agregar archivos de traducción a la app. Para personalizar instrucciones de captura, prueba de vida o mensajes locales de carga y conexión, consulta la [guía de localización](LOCALIZACION.md). Solo necesitas agregar las claves que quieras modificar.

## Recibir resultados y manejar la cancelación

`BDIVResponseSuccess(bdivResult:)` entrega `BDIdentityVerificationResponse`, con `responseStatus`, `message` y los resultados opcionales del flujo:

| Resultado | Campos públicos | Cómo utilizarlo |
| --- | --- | --- |
| `onboarding` | `code`, `message`, `urlResource`, `userId` | Confirma la creación cuando `performVerificationCheck=false`. No equivale a una aprobación final. |
| `verification` | `urlGetData` | Resultado final de onboarding cuando se espera su finalización. |
| `authentication` | `company`, `confidence`, `executionId`, `liveness`, `result`, `userId` | Resultado de autenticación. Evalúa también `result` antes de continuar en la app. |

Consulta únicamente el resultado que corresponda al flujo; los demás objetos pueden ser `nil`. El estado `SUCCES` indica que la operación de la SDK terminó correctamente; no sustituye la evaluación del resultado de autenticación. No consideres aprobados los estados `PENDING` o `NOFOUND`.

La respuesta dispone de `toJson()` si necesitas representarla como texto. Los errores y la cancelación se entregan mediante `BDIVResponseError(error:)`. Los mensajes son descriptivos: no los uses como códigos fijos para aprobar verificaciones ni para decidir reintentos automáticos. Consulta el [manejo de errores](ERRORES.md).

## Guías de integración

- [Demo de integración para iOS](Demo/iOSBlinkIDIntegration/README.md)
- [Instalación, dependencias, licencia y permisos](INSTALACION.md)
- [Localización y claves admitidas](LOCALIZACION.md)
- [Resultados y errores](ERRORES.md)
- [Diagnóstico y soporte](LOGGING.md)
- [Protección contra capturas de pantalla](SCREEN_CAPTURE_CONFIGURATION.md)
- [Eventos en segundo plano](CARGAS_SEGUNDO_PLANO.md)
- [Cambios de la SDK](CHANGELOG.md)

Antes de publicar tu app, comprueba los permisos, la captura de los lados solicitados, los reintentos, la validación facial, los idiomas personalizados, la cancelación y el manejo de resultados.
