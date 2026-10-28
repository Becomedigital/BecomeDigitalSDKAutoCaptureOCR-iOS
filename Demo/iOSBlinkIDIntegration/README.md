# Demo de integración para iOS

Esta aplicación muestra cómo iniciar una verificación de identidad desde una pantalla SwiftUI y recibir los resultados en un controlador UIKit que implementa `BDIVDelegate`. Utiliza `BDIdentityVerification.xcframework` desde la raíz de esta distribución. El proyecto Xcode fija las versiones de sus dependencias.

## Preparar el demo

1. Abre [iOSBlinkIDIntegration.xcodeproj](iOSBlinkIDIntegration.xcodeproj) en Xcode y selecciona el target `iOSBlinkIDIntegration`.
2. Selecciona tu equipo de firma y reemplaza `PRODUCT_BUNDLE_IDENTIFIER` por el identificador de aplicación autorizado para tu licencia BlinkID. `com.example.become.integration` es solo un valor de ejemplo.
3. Copia `App/DemoConfiguration.example.plist` como `App/DemoConfiguration.plist`. Completa `clientId`, `clientSecret` y `contractId` con los valores asignados a tu contrato. El ejemplo activa `debugLogsEnabled` para las pruebas manuales; desactívalo en una aplicación de producción.
4. Guarda la licencia BlinkID asignada a ese identificador de aplicación en `App/com.become.blinkid.key.txt`.
5. Compila y ejecuta la aplicación en un dispositivo físico con iOS 16 o posterior. Ingresa un ID de usuario y toca **Iniciar verificación**.

Solicita a BecomeDigital las credenciales, el identificador del contrato y la licencia correspondientes a tu aplicación. Estos datos no se incluyen en el demo. Si falta la configuración o la licencia, la aplicación muestra un aviso y no inicia la verificación. Los dos archivos locales se excluyen de Git y se copian a la aplicación solo durante una compilación local. No distribuyas una compilación que contenga credenciales de prueba.

## Estructura del proyecto

- `VerificationScreen.swift` define la pantalla SwiftUI y entrega el ID de usuario al controlador.
- `ViewController.swift` presenta esa pantalla con `UIHostingController`, crea `BDIVConfig`, conserva la instancia de la SDK y recibe `BDIVResponseSuccess` y `BDIVResponseError`.
- `AppDelegate.swift` reenvía los eventos de sesión en segundo plano a la SDK. `SceneDelegate.swift` crea la ventana para el ciclo de vida de escenas de UIKit.
- `Info.plist` declara los permisos de cámara y ubicación y la configuración de escenas. Los archivos `Localizable.strings` muestran la localización al español de la SDK y la aplicación anfitriona.
- `generate_project.rb` permite regenerar el proyecto Xcode cuando cambia su estructura. Requiere la gema Ruby `xcodeproj`.

Consulta la [guía de instalación](../../INSTALACION.md), la [guía de localización](../../LOCALIZACION.md), la [guía de diagnóstico](../../LOGGING.md) y la [guía de errores](../../ERRORES.md) para adaptar esta integración a tu aplicación.
