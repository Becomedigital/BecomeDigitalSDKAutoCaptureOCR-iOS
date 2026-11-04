# Migrar la integración de iOS a Swift Package Manager

Estos pasos reemplazan la integración de BecomeDigital por archivo por el paquete publicado. Conserva la configuración de tu contrato, los JWT, la licencia de la app y las personalizaciones que utilizas.

## Retirar la integración anterior

1. Identifica el target que inicia la verificación y las referencias que agregaste para la integración anterior.
2. Retira su copia local de `BDIdentityVerification.xcframework` y las entradas correspondientes de **Link Binary With Libraries**, **Embed Frameworks** y **Frameworks, Libraries, and Embedded Content**.
3. Retira los productos, copias locales y rutas de búsqueda que agregaste exclusivamente para las dependencias de esa integración. Conserva los que tu propia app utilice directamente y compara sus requisitos con la [referencia de dependencias compartidas](DEPENDENCIAS.md).
4. Conserva `com.become.blinkid.key.txt`, las descripciones de permisos y los archivos de localización de tu aplicación.

## Agregar el paquete publicado

Sigue la [instalación con SPM](INSTALACION.md#agregar-el-paquete): agrega el repositorio de BecomeDigital, selecciona **Exact Version** con `3.5.1-rc.1` y asocia únicamente el producto `BDIdentityVerification` al target de tu app. SPM resuelve automáticamente las demás dependencias.

El módulo importado sigue siendo `BDIdentityVerification`. Continúa con la [inicialización y configuración pública](README.md#iniciar-una-verificación). Si además vienes de una versión con firma de credenciales, consulta por separado la [migración a JWT](AUTENTICACION.md).

## Verificar el resultado

Confirma que el proyecto resuelva la versión exacta y compile para los destinos que admite tu aplicación. En un dispositivo físico, prueba la licencia, los permisos, la captura, la validación facial, la cancelación y los resultados antes de distribuir tu app.
