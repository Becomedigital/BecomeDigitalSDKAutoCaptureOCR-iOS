# SDK de BecomeDigital AutoCapture OCR para iOS

Verificación de identidad nativa con captura automática de documentos, reconocimiento mediante OCR, alternativa de captura manual y validación facial. Este repositorio distribuye `BDIdentityVerification.xcframework` y la documentación de integración para las aplicaciones cliente.

## Funcionalidades

- Onboarding y autenticación con respuestas tipadas.
- Captura automática con guía de encuadre, indicaciones de calidad de imagen e instrucciones para frente y reverso.
- Captura manual disponible después de 30 segundos de forma predeterminada si la captura automática no termina, con reconocimiento del documento y opción de volver a intentar.
- Pantallas SwiftUI, selección de país con búsqueda, identidad visual y textos asignados al contrato.
- Modo claro, oscuro o del sistema elegido por la app, y protección opcional contra capturas de pantalla.

## Requisitos y dependencias

| Componente | Versión requerida |
| --- | --- |
| iOS | 16.0 o posterior |
| Framework de la SDK de Become | 1.2.3 |
| Amplify Swift | 2.53.3 |
| Amplify UI Swift Liveness | 1.4.4 |
| Paquete BlinkID para iOS | 8002.0.2 |
| Herramientas de compilación de Xcode | Compatibles con Swift 6 |

El XCFramework incluye las variantes arm64 para dispositivos iOS y arm64/x86_64 para el simulador. La distribución es binaria; este repositorio no se agrega directamente como paquete Swift.

## Instalación

1. Descarga o clona este repositorio y agrega `BDIdentityVerification.xcframework` al target de la aplicación.
2. En **Frameworks, Libraries, and Embedded Content**, selecciona **Embed & Sign** para integrarlo y firmarlo.
3. Agrega estos paquetes en Xcode con la opción **Exact Version**:

| URL del paquete | Versión |
| --- | --- |
| `https://github.com/aws-amplify/amplify-swift` | 2.53.3 |
| `https://github.com/aws-amplify/amplify-ui-swift-liveness` | 1.4.4 |
| `https://github.com/microblink/blinkid-ios` | 8002.0.2 |

Agrega al target los productos requeridos de Amplify y Face Liveness. Agrega el producto **BlinkIDUX**; su paquete también incluye la dependencia binaria **BlinkID**. Verifica que el directorio `Frameworks` de la app compilada contenga **BDIdentityVerification.framework**, **BlinkID.framework** y **BlinkIDUX.framework**, integrados y firmados.

Si vienes de la integración anterior de Capture, elimina sus referencias a los paquetes Capture Core/UX y sus frameworks integrados. El módulo Swift sigue siendo `BDIdentityVerification`; el nombre del repositorio no cambia la API pública.

### Licencia de la aplicación

Solicita a BecomeDigital una licencia BlinkID Core para el **Bundle Identifier** de tu app. Agrega el archivo `com.become.blinkid.key.txt` al target y a **Copy Bundle Resources**. Este repositorio no incluye el contenido de las licencias ni las credenciales de las aplicaciones. Un Bundle Identifier diferente, incluido el de una variante de desarrollo, requiere su propia licencia.

### Permisos

Agrega la descripción de uso de la cámara al `Info.plist` de la app:

```xml
<key>NSCameraUsageDescription</key>
<string>Necesitamos acceso a la cámara para verificar tu identidad.</string>
```

Si la app usa ubicación, agrega también `NSLocationWhenInUseUsageDescription`.

## Iniciar la verificación

El delegado debe ser un `UIViewController` que implemente `BDIVDelegate`. Conserva la instancia de la SDK durante todo el flujo.

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
        if let started = bdivResult.onboarding { _ = started.userId }
        if let completed = bdivResult.verification { _ = completed.urlGetData }
        if let authentication = bdivResult.authentication {
            // Evalúa el resultado de autenticación por separado del estado del callback.
            _ = authentication.result
        }
    }

    func BDIVResponseError(error: String) {
        // Restaura la interfaz de la app y permite que el usuario inicie un nuevo intento.
    }
}
```

Los nombres `clienId`, `documenTypes` y `SUCCES` se conservan por compatibilidad. Para autenticación usa `flow: .Authentication`; puedes usar `documenTypes: []` cuando no se requiera capturar documentos.

## Configuración pública

| Parámetro | Valor predeterminado | Uso |
| --- | --- | --- |
| `clienId`, `clientSecret`, `contractId`, `userId` | Requeridos | Identifican al cliente, el contrato y el usuario. |
| `documenTypes` | Requerido en onboarding | `.DNI`, `.PASSPORT`, `.DRIVERLICENSE`; en autenticación puede usarse `[]`. |
| `flow` | `.Onboarding` | `.Onboarding` o `.Authentication`. |
| `performVerificationCheck` | `true` | Espera el resultado final de onboarding. |
| `pollingMaxAttempts` | `0` | Máximo de consultas del resultado; `0` no limita los intentos. |
| `pollingTimeout` | 2 segundos | Tiempo máximo de cada consulta del resultado, no de todo el flujo. |
| `debugLogsEnabled` | `false` | Habilita registros de diagnóstico durante una revisión. |
| `preventScreenCapture` | `false` | Habilita la protección de las pantallas de la SDK contra capturas. |
| `country`, `state` | `nil` | Código de país de dos letras y estado de EE. UU. precargados, cuando corresponda. |
| `nationalIdType`, `nationalIdTypeChoices`, `documentNumber` | Vacíos | Datos opcionales del documento precargados. |
| `themeMode` | `.system` | `.light`, `.dark` o `.system`. |

La SDK aplica los pasos, apariencia y textos asignados al contrato. `BDIVConfig` no configura el diseño ni los textos del recorrido. Los archivos locales son opcionales para instrucciones de los componentes nativos y etiquetas técnicas de carga o red; consulta la [guía de textos nativos](LOCALIZACION.md).

La animación de carga inicial permanece visible hasta que el flujo y su presentación estén listos. Al inicio usa el recurso `AccentColor` o el color de énfasis heredado de la app y un mensaje de carga localizado. El primer paso visible ya muestra la apariencia configurada. Los errores de inicialización se entregan mediante el callback de error existente.

Si una consulta del resultado necesita más tiempo, asigna un `pollingTimeout` mayor, por ejemplo `30`. Este valor es independiente de los 30 segundos predeterminados para habilitar la alternativa de captura manual.

## Respuestas tipadas

`BDIVResponseSuccess` entrega `BDIdentityVerificationResponse`, con `responseStatus`, `message` y objetos de resultado opcionales:

| Objeto | Campos públicos | Uso |
| --- | --- | --- |
| `onboarding` | `code`, `message`, `urlResource`, `userId` | Confirma el inicio cuando `performVerificationCheck=false`; no representa una aprobación final. |
| `verification` | `urlGetData` | Resultado final de onboarding cuando está habilitada la consulta del resultado. |
| `authentication` | `company`, `confidence`, `executionId`, `liveness`, `result`, `userId` | Datos de autenticación; evalúa `result` por separado. |

Consulta únicamente el objeto que corresponda al flujo. Los errores y la cancelación se entregan mediante `BDIVResponseError(error:)`; consulta el [manejo de errores](ERRORES.md). Usa los objetos concretos de resultado en lugar de acceder a un diccionario de respuesta.

## Guías de integración

- [Manejo de errores](ERRORES.md)
- [Idioma y textos locales opcionales](LOCALIZACION.md)
- [Registros de diagnóstico](LOGGING.md)
- [Protección contra capturas de pantalla](SCREEN_CAPTURE_CONFIGURATION.md)
- [Eventos en segundo plano](CARGAS_SEGUNDO_PLANO.md)
- [Sumas de verificación de los artefactos](CHECKSUMS.sha256)

Antes de publicar la app, prueba en un dispositivo físico la captura automática y manual, los reintentos, los permisos, la validación facial, los callbacks y la cancelación. Usa el identificador de aplicación que corresponda a la licencia.
