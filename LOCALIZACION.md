# Localización y personalización de textos — iOS

## Configuración

1. Agrega [Localizable.strings](Localizable.strings) al target de la app o copia solo las claves necesarias en su tabla actual.
2. Conserva los nombres de las claves y edita únicamente los valores.
3. Crea las variantes por idioma, por ejemplo `es.lproj/Localizable.strings` y `en.lproj/Localizable.strings`.
4. Recompila la app. `BDIVConfig` no selecciona una tabla de localización.

Las claves nativas definidas por la app tienen prioridad para esas frases específicas. Las claves que falten conservan el texto asignado al contrato o el valor predeterminado de la SDK. Personaliza cada idioma admitido. Cambiar los recursos de texto no requiere recompilar el binario de la SDK.

## Claves por pantalla

Una clave compartida cambia todas las pantallas que la usan. Copia los nombres completos de la plantilla; `*` indica un prefijo, no una clave literal.

| Pantalla o uso | Claves |
| --- | --- |
| Introducción | `text_tittle_general_intro`, `text_sub_tittle_general_intro`, `text_selfie_intro_general`, `text_document_intr_general`, `text_start_btn` |
| Selección de país y documento | `text_tittle_selec_document`, `text_body_country`, `text_select_country`, `text_cancel_close`, `text_dni_selec_document`, `text_license`, `text_passport` |
| Introducción facial | `text_video_intro` |
| Captura documental | `text_tittle_intro_doc_front`, `text_btn_introduction_doc` |
| Vista previa | `text_info_preview`, `text_confirm_preview`, `text_retry_previe` |
| Carga y envío | `text_loader_init`, `text_loading`, `text_varification_title`, `text_varification_body`, `text_varification_buttom`, `text_info_upload`, `text_info_upload_document`, `text_document_validation` |
| Consulta del resultado | `text_progress_result`, `text_progress_delay_result`, `text_progress_delay_finish_result` |
| Error documental y reintento | `text_title_document_error`, `text_sub_title_document_error`, `text_title_button_retry` |
| Creación y resultados: cierre facial, nueva captura y reintento | Claves `identity_error_*` de la plantilla. |
| Error general o validación fallida | `text_varification_title_error`, `text_varification_body_error`, `text_varification_title_compliance_error`, `text_varification_body_compliance_error`, `text_error_compliance_not_allowed`, `general_error`, `unknown_error` |
| Errores de conexión | `timeout_error`, `no_internet_error`, `connection_lost_error` |
| Permisos y privacidad | `tittle_permisiions_not_aut`, `camera_error_permissions`, `text_screen_recording_not_allowed` |
| Error facial | `liveness_detection_failed`, `error_low_confidence` |
| Callback de error de configuración | `text_msn_error_config`, `error_clientid_empty`, `error_client_secret_empty`, `error_contractid_empty`, `error_userid_emty`, `error_vallidationtype_empty` |
| Resultado final | `text_finish`, `text_sub_tittle_finish`, `terminate_text` |
| Confirmación de salida | `text_undo`, `text_cancel`, `text_tittle_undo`, `text_sub_tittle_undo`, `cancel_by_user` |
| Face Liveness: preparación y fotosensibilidad | `amplify_ui_liveness_get_ready_*` |
| Face Liveness: instrucciones de captura | `amplify_ui_liveness_challenge_*`, `amplify_ui_liveness_face_not_prepared_reason_*`, `amplify_ui_liveness_center_your_face_text` |
| Face Liveness: permisos y cierre | `amplify_ui_liveness_camera_*`, `amplify_ui_liveness_close_button_a11y` |

## Instrucciones de captura

BlinkID UX incluye sus propias instrucciones de captura localizadas. Las claves `mbic_*` que se conservan en los ejemplos corresponden a la interfaz anterior de Capture y no personalizan BlinkID UX. Para su interfaz de captura, usa los recursos de la versión fijada de BlinkID UX. Las pantallas de introducción, vista previa y error de Become usan las claves indicadas arriba.

## Formato y verificación

- Conserva el significado de las instrucciones de cámara, accesibilidad y fotosensibilidad.
- Mantén los marcadores de formato y los saltos de línea intencionales. Conserva `%d%%` para el progreso de carga y `%@` en los mensajes de error facial de la plantilla iOS.
- No cambies nombres de claves para corregir su escritura ni dupliques entradas de un mismo idioma.
- Después de recompilar la app, verifica en un dispositivo físico la introducción, captura, reintentos, errores, carga y resultados en cada idioma admitido.
