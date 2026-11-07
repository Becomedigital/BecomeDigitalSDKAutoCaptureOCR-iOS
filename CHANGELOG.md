# Cambios de la SDK

## 5.3.2 — 2026-11-06

### Cambios

- La revisión del documento muestra una cara a la vez y permite alternar entre las imágenes conservando sus proporciones.

### Correcciones

- Evita que las imágenes del documento desborden el espacio disponible durante la revisión.
- Solicita repetir la captura automática cuando falta la imagen necesaria para revisar el documento.

## 5.3.2-rc.1 — 2026-11-05

### Cambios

- La revisión del documento muestra una cara a la vez y permite alternar entre las imágenes conservando sus proporciones.

### Correcciones

- Evita que las imágenes del documento desborden el espacio disponible durante la revisión.
- Solicita repetir la captura automática cuando falta la imagen necesaria para revisar el documento.

## 3.5.1 — 2026-11-05

### Novedades

- Permite integrar la verificación de identidad mediante Swift Package Manager con una versión exacta.
- Incluye la declaración de privacidad de los datos utilizados durante la verificación, incluida la ubicación cuando se recolecta con autorización.

### Cambios

- Actualiza las ilustraciones de introducción de documento y rostro, conservando su transparencia y adaptación a los modos claro y oscuro.

### Correcciones

- Corrige la alineación de la cámara y los controles al girar el dispositivo durante la captura del documento.
- Mantiene alineadas la vista previa y la fotografía en la alternativa de captura manual.
- Evita los recuadros blancos exteriores en las ilustraciones de introducción al usar modo oscuro.

## 3.5.1-rc.3 — 2026-11-05

### Cambios

- Actualiza las ilustraciones de introducción de documento y rostro, conservando su transparencia y adaptación a los modos claro y oscuro.

### Correcciones

- Evita los recuadros blancos exteriores en las ilustraciones de introducción al usar modo oscuro.

## 3.5.1-rc.2 — 2026-11-04

### Correcciones

- Corrige la alineación de la cámara y los controles al girar el dispositivo durante la captura del documento.
- Mantiene alineadas la vista previa y la fotografía en la alternativa de captura manual.

## 3.5.1-rc.1 — 2026-11-04

### Novedades

- Incluye la declaración de privacidad de los datos utilizados durante la verificación, incluida la ubicación cuando se recolecta con autorización.

## Actualización de autenticación — 29 de octubre de 2026

- Agrega la firma de inicialización con JWT obtenido por la integración.
- Permite utilizar tokens distintos para crear la verificación y consultar su resultado mediante `verificationResultsJwt`.
- Incluye compatibilidad de integración para iPhone físico y simuladores en Mac con Apple Silicon o Intel.
- Conserva la firma anterior con credenciales, marcada como deprecada con indicaciones de migración.
- Mantiene los resultados, callbacks y parámetros opcionales de las integraciones existentes.
- Actualiza el demo para utilizar JWT como ejemplo recomendado.
- Conserva la captura automática de documentos con reconocimiento OCR y la alternativa manual.

Consulta los [ejemplos de ambas firmas y la guía de migración](AUTENTICACION.md).

## Validación facial — 27 de octubre de 2026

- Mejora la compatibilidad del envío de selfies para su validación.
- Respeta el límite de intentos automáticos de validación de la selfie.
- Amplía el diagnóstico opcional para identificar los motivos de repetición de la captura facial.
- Actualiza los textos predeterminados y la aplicación de las personalizaciones del contrato.
- Corrige cierres por recursos faltantes al iniciar la validación facial.

Después de reemplazar el archivo de la SDK, compila tu app con las dependencias de la [guía de instalación](INSTALACION.md) y comprueba la verificación completa en un dispositivo físico. La API de inicialización de esta entrega se describe en el [README](README.md).
