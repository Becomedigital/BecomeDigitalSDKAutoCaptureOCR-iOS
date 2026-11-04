# Instalación para iOS con Swift Package Manager

Agrega BecomeDigital a tu aplicación desde Swift Package Manager (SPM). Xcode descarga el paquete y resuelve automáticamente las dependencias declaradas; solo debes agregar el producto de BecomeDigital al target de tu app.

## Requisitos

| Requisito | Valor |
| --- | --- |
| Versión publicada usada en esta guía | `3.5.1-rc.1` |
| iOS mínimo | 16.0 |
| Herramientas | Xcode compatible con Swift 6.4 |
| Dispositivos | `arm64` |
| Simulador | `arm64` y `x86_64` |

`3.5.1-rc.1` es una versión candidata para evaluación. La versión interna del framework es `3.5.1`. Las funciones de cámara, documento y validación facial se prueban en un dispositivo físico con una licencia emitida para el **Bundle Identifier** de tu app.

## Agregar el paquete

1. Abre el proyecto de tu aplicación en Xcode.
2. Selecciona **File > Add Package Dependencies** e ingresa esta URL:

   ```text
   https://github.com/Becomedigital/BecomeDigitalSDKAutoCaptureOCR-iOS.git
   ```

3. En **Dependency Rule**, selecciona **Exact Version** y escribe `3.5.1-rc.1`.
4. Selecciona **Add Package** y agrega el producto **`BDIdentityVerification`** al target de tu app.
5. Espera a que Xcode termine de resolver y descargar el paquete. Comprueba en **Package Dependencies** la versión seleccionada.

SPM obtiene el binario de BecomeDigital y sus dependencias. No necesitas descargar archivos de otras bibliotecas, agregar sus productos ni configurar sus versiones por separado. Mantén las dependencias propias que tu aplicación utilice directamente. Si tu app ya utiliza paquetes compartidos, compara sus versiones y reglas con la [guía de dependencias y compatibilidad](DEPENDENCIAS.md).

Si tu aplicación ya usa la distribución por archivo, sigue primero la [migración a SPM](MIGRACION.md) para evitar copias duplicadas.

## Agregar la licencia de la app

Solicita a BecomeDigital la licencia correspondiente a tu app y agrégala con el nombre **`com.become.blinkid.key.txt`**. Marca su pertenencia al target de la app e inclúyela en **Copy Bundle Resources**.

La licencia debe corresponder al Bundle Identifier exacto. Una variante con otro identificador necesita su propia licencia. No incluyas el contenido de la licencia en documentación ni en registros que compartas.

## Permisos

Agrega al `Info.plist` una descripción de uso de la cámara:

```xml
<key>NSCameraUsageDescription</key>
<string>Necesitamos acceso a la cámara para verificar tu identidad.</string>
```

Si tu integración utiliza ubicación, agrega también `NSLocationWhenInUseUsageDescription` con una descripción de su finalidad. Revisa el acceso a la cámara antes de volver a intentar una verificación cuando el usuario haya denegado el permiso.

## Orientaciones de la aplicación

Declara en `Info.plist` las orientaciones que admite tu app mediante `UISupportedInterfaceOrientations`. Para una aplicación que permite vertical y horizontal, esta es una configuración de ejemplo:

```xml
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
```

Conserva las orientaciones permitidas por tu aplicación. Si el target usa `UISupportedInterfaceOrientations~ipad`, revisa también su configuración. La captura sigue la orientación de la escena que la presenta. En un dispositivo físico, comprueba ambos giros, el regreso a vertical, el bloqueo de rotación y la alternativa de captura manual.

## Comprobar la integración

1. Confirma que el producto `BDIdentityVerification` esté asociado al target correcto y que la resolución indique `3.5.1-rc.1`.
2. Importa el módulo en tu aplicación:

   ```swift
   import BDIdentityVerification
   ```

3. Compila para un dispositivo iOS y, cuando lo necesites, para un simulador compatible. Xcode gestiona el enlace y la inclusión de las dependencias del paquete.
4. Sigue el [ejemplo de inicialización](README.md#iniciar-una-verificación) con los JWT y el contrato de tu integración.
5. En un dispositivo físico, verifica los permisos, la captura documental, la validación facial, la cancelación y los resultados. Usa también la configuración de publicación de tu app.

## Resolver problemas de instalación

| Situación | Qué revisar |
| --- | --- |
| Xcode no resuelve el paquete | Usa la URL completa y la versión exacta publicada; revisa la conexión y el acceso a las descargas del paquete. |
| Herramientas Swift incompatibles | Selecciona una instalación de Xcode compatible con Swift 6.4. |
| Módulo duplicado o error de enlace | Retira las referencias locales anteriores siguiendo la [guía de migración](MIGRACION.md) y conserva una sola integración de BecomeDigital. |
| No se encuentra `BDIdentityVerification` | Asocia el producto del paquete al target que contiene el código que lo importa. |
| La verificación no acepta la licencia | Comprueba el nombre del archivo, su inclusión en la app y el Bundle Identifier autorizado. |

Consulta la [localización](LOCALIZACION.md), el [manejo de errores](ERRORES.md) y el [demo de integración](Demo/iOSBlinkIDIntegration/README.md) para continuar.
