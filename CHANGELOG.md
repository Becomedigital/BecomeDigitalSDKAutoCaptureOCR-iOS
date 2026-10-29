# Cambios de la SDK

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
