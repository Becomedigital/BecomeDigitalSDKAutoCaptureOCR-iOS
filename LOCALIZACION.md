# Textos de componentes nativos — iOS

## Textos del recorrido

Los títulos, instrucciones, consentimiento, selección de país y documento, introducciones, revisión y resultados de Become se administran desde la configuración del contrato. No copies archivos de traducción para configurar ese recorrido. Las claves faltantes conservan los valores predeterminados.

Esta guía y sus ejemplos incluyen únicamente claves de componentes nativos y etiquetas técnicas locales. Retira de los archivos de la app las antiguas claves del flujo si esas frases deben seguir las actualizaciones del contrato. Un override local compatible puede fijar una frase y ocultar su actualización; no copies la plantilla completa.

## Etiquetas técnicas de la SDK

Estas etiquetas todavía consultan recursos locales y no se cambian mediante los textos del contrato. Los ejemplos conservan únicamente las claves verificadas: carga inicial `text_loader_init`; errores de red `timeout_error`, `no_internet_error` y `connection_lost_error`; progreso `text_info_upload` y `text_info_upload_document` (conserva `%d%%`).

No son un catálogo de títulos o acciones del recorrido.

## Componentes admitidos

| Componente | Versión verificada | Claves locales |
| --- | --- | --- |
| BlinkID UX | 8002.0.2 | `mb_*` |
| Amplify Face Liveness | 1.4.4 / 1.4.5 | `amplify_ui_liveness_*` |

Las claves `mbic_*` pertenecen a Capture Legacy y no personalizan BlinkID UX. Los nombres difieren entre iOS y Android; conserva los de esta distribución.

## Personalización opcional

Agrega solo las entradas que necesitas a `Localizable.strings` del target de la app:

```text
"mb_camera_flip_document" = "Voltea el documento";
"amplify_ui_liveness_challenge_connecting" = "Conectando…";
```

BlinkID UX consulta la tabla `Localizable` de la app y conserva su traducción nativa cuando falta una clave. Amplify también consulta el bundle principal de la app; sus textos se resuelven durante la inicialización. La versión integrada no ofrece una API pública para inyectar los textos del contrato dentro del detector de iOS. Esto no afecta los textos del recorrido facial de Become.

Agrega el archivo al target de la app y usa variantes como `es.lproj/Localizable.strings` y `en.lproj/Localizable.strings`. Consulta la [referencia opcional de claves nativas](Localizable.strings).

## Verificación

Conserva los nombres, mayúsculas, marcadores de formato y el significado de las instrucciones de seguridad y fotosensibilidad. Modifica únicamente los valores necesarios. Recompila la app después de cambiar recursos; no necesitas recompilar la SDK. Verifica los idiomas personalizados en un dispositivo físico. `BDIVConfig` no selecciona una tabla de traducciones ni configura los textos del recorrido.
