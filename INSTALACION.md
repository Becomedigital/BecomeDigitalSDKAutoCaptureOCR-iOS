# Instalación de la SDK para iOS

## Requisitos

| Requisito | Valor |
| --- | --- |
| iOS mínimo | 16.0 |
| Framework de BecomeDigital | 1.2.3 |
| Herramientas | Xcode compatible con Swift 6.4 |
| Dispositivos | arm64 |
| Simulador | arm64 y x86_64 |

Las funciones de cámara y verificación requieren un dispositivo físico. Usa la licencia emitida para el **Bundle Identifier** de tu app.

## Agregar la SDK y sus dependencias

1. Descarga `BDIdentityVerification.xcframework` de esta distribución y agrégalo al target de tu app.
2. En **Frameworks, Libraries, and Embedded Content**, selecciona **Embed & Sign**.
3. En **File > Add Package Dependencies**, agrega los siguientes paquetes con **Exact Version** y vincula los productos indicados al target:

| URL del paquete | Versión | Producto |
| --- | --- | --- |
| `https://github.com/aws-amplify/amplify-swift` | 2.53.3 | `Amplify` |
| `https://github.com/aws-amplify/amplify-ui-swift-liveness` | 1.4.4 | `FaceLiveness` |
| `https://github.com/microblink/blinkid-ios` | 8002.0.2 | `BlinkIDUX` |

4. Integra y firma `BDIdentityVerification.framework`, `BlinkID.framework` y `BlinkIDUX.framework`. Deben quedar incluidos en la app final. Swift Package Manager resuelve las demás dependencias de los paquetes.
5. Si reemplazas otra distribución de BecomeDigital, retira sus archivos y dependencias de captura anteriores antes de agregar los de esta entrega. Evita agregar dos copias del mismo framework.

Incluye las dependencias indicadas aunque tu contrato no muestre la captura facial. Si tu app ya utiliza Amplify, mantén versiones compatibles con esta entrega. El módulo que importa tu código es `BDIdentityVerification`.

## Agregar la licencia

Solicita a BecomeDigital la licencia correspondiente a tu app y agrégala con el nombre **`com.become.blinkid.key.txt`**. Marca su pertenencia al target de la app e inclúyela en **Copy Bundle Resources**.

La licencia debe corresponder al Bundle Identifier exacto. Una variante con otro identificador necesita su propia licencia. No incluyas el contenido de la licencia en documentación ni en registros que compartas.

## Permisos

Agrega al `Info.plist` una descripción de uso de la cámara:

```xml
<key>NSCameraUsageDescription</key>
<string>Necesitamos acceso a la cámara para verificar tu identidad.</string>
```

Si tu integración utiliza ubicación, agrega también `NSLocationWhenInUseUsageDescription`. Revisa el acceso a la cámara antes de volver a intentar una verificación cuando el usuario haya denegado el permiso.

## Continuar con la integración

Sigue el [ejemplo de inicialización](README.md#iniciar-una-verificación). Para adaptar instrucciones de captura o prueba de vida, consulta las [claves de localización](LOCALIZACION.md).
