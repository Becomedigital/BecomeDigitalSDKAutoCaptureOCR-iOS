# Demo de integración para iOS

Esta aplicación utiliza el archivo de la SDK incluido en la raíz de esta distribución y la firma recomendada con JWT. Muestra cómo iniciar la verificación y recibir sus resultados desde una pantalla SwiftUI con un controlador UIKit.

## Preparar el demo

1. Abre [iOSBlinkIDIntegration.xcodeproj](iOSBlinkIDIntegration.xcodeproj) en Xcode y selecciona el target `iOSBlinkIDIntegration`.
2. Selecciona tu equipo de firma y el identificador de aplicación autorizado para tu licencia BlinkID.
3. Copia `App/DemoConfiguration.example.plist` como `App/DemoConfiguration.plist`. Completa `jwt` y `contractId`; configura `debugLogsEnabled` según necesites diagnóstico.
4. Agrega la licencia de tu app como `App/com.become.blinkid.key.txt`.
5. Compila y ejecuta la app en un dispositivo físico con iOS 16 o posterior. Ingresa un ID de usuario y toca **Iniciar verificación**.

El JWT debe estar vigente, corresponder a producción y autorizar tu contrato y flujo. Introduce solo el token, sin el prefijo `Bearer `. Los archivos de configuración y licencia son locales y sus valores no se incluyen en esta distribución.

## Usar el ejemplo en tu aplicación

El archivo `App/DemoConfiguration.plist` permite introducir un JWT únicamente para esta prueba local. El valor queda incorporado a la app compilada; no publiques una app con un token de prueba. En tu integración real, obtén el JWT desde tu backend antes de iniciar la SDK y renueva los tokens vencidos. El demo no solicita ni renueva tokens.

Si falta la configuración o la licencia, el demo muestra un mensaje y no inicia la verificación. `ViewController.swift` crea `BDIVConfig`, conserva los objetos necesarios y maneja los callbacks. La configuración local de diagnóstico sirve para revisar tus pruebas; desactívala al terminar.

La firma con credenciales sigue disponible y deprecada. Los ejemplos de ambas firmas y los pasos de migración están en la [guía de autenticación](../../AUTENTICACION.md).

Consulta también la [instalación](../../INSTALACION.md), [localización](../../LOCALIZACION.md), [diagnóstico](../../LOGGING.md) y [manejo de errores](../../ERRORES.md).
