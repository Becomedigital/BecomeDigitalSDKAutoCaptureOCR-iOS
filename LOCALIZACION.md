# Localización de la SDK para iOS

## Textos del recorrido

Los títulos, instrucciones, consentimiento, selección de país y documento, introducciones y resultados se administran en la configuración de tu contrato. No necesitas copiar archivos de traducción para recibirlos. Cuando falta un texto, se conserva el valor predeterminado de la SDK.

Los archivos locales son opcionales para las instrucciones de captura, prueba de vida y mensajes de carga o conexión que se describen aquí. Agrega únicamente las claves que quieras personalizar. Si conservas personalizaciones locales antiguas del recorrido, revísalas para evitar que impidan aplicar cambios posteriores del contrato.

## Claves admitidas

| Componente | Versión de esta distribución | Prefijo de las claves |
| --- | --- | --- |
| BlinkID UX | 8002.0.2 | `mb_*` |
| Amplify Face Liveness | 1.4.4 | `amplify_ui_liveness_*` |

Usa la [plantilla en español](Localizable.strings) para consultar los nombres exactos y sus valores de referencia. Los nombres difieren entre plataformas y distribuciones; usa solo las claves que corresponden a esta entrega.

También puedes adaptar estos mensajes locales:

| Mensaje | Claves |
| --- | --- |
| Carga inicial | `text_loader_init` |
| Conexión | `timeout_error`, `no_internet_error`, `connection_lost_error` |
| Progreso | `text_info_upload` y `text_info_upload_document`; conserva `%d%%` donde aparezca. |

## Personalizar los textos

```text
"mb_camera_flip_document" = "Voltea el documento";
"amplify_ui_liveness_challenge_connecting" = "Conectando…";
```

Agrega `Localizable.strings` al target de la app y crea las variantes de idioma, por ejemplo `es.lproj/Localizable.strings` y `en.lproj/Localizable.strings`. Los componentes conservan sus traducciones predeterminadas para las claves que no definas. Las instrucciones del detector facial de iOS se personalizan con las claves nativas indicadas en esta guía.

## Comprobar la personalización

Conserva los nombres exactos, las mayúsculas y los marcadores de formato. Mantén el significado de las instrucciones de seguridad y fotosensibilidad. Compila de nuevo tu app tras cambiar los recursos y comprueba cada idioma en un dispositivo físico. No necesitas reemplazar la SDK para cambiar estos valores locales.

Vuelve a la [guía de integración](README.md).

## Catálogo de claves

Copia solo las entradas que vayas a personalizar. Conserva los marcadores de formato y los saltos de línea.

### Carga, progreso y conexión

| Clave | Valor de referencia en español |
| --- | --- |
| `text_loader_init` | Iniciando… |
| `timeout_error` | La conexión tardó demasiado. Inténtalo nuevamente. |
| `no_internet_error` | No tienes conexión a internet. Verifica tu red. |
| `connection_lost_error` | Se perdió la conexión a internet. Inténtalo nuevamente. |
| `text_info_upload` | Estamos enviando tu información… %d%% |
| `text_info_upload_document` | Estamos enviando tus documentos… %d%% |

### Captura de documentos

| Clave | Valor de referencia en español |
| --- | --- |
| `mb_accessibility_success_document_scanned` | Documento escaneado correctamente |
| `mb_accessibility_success_first_side_scanned` | Frente escaneado correctamente |
| `mb_back_instructions` | Escanea el reverso del documento |
| `mb_barcode_id_instructions` | Escanea el lado del documento que tiene el código de barras |
| `mb_barcode_instructions` | Escanea el código de barras |
| `mb_blur_detected` | Mantén quietos el documento y el teléfono |
| `mb_camera_flip_document` | Voltea el documento para escanear el reverso |
| `mb_camera_permission_required` | Se necesita permiso para acceder a la cámara. |
| `mb_close` | Cerrar |
| `mb_connection_reconnect` | Toca dos veces para intentar conectarte de nuevo a Internet |
| `mb_connection_retry` | Reintentar conexión |
| `mb_connection_try_again` | Revisa tu conexión a Internet y vuelve a intentarlo |
| `mb_decrease_lighting_intensity` | Ubícate en un lugar con menos iluminación |
| `mb_dialog_back_button` | Volver |
| `mb_dialog_done_button` | Listo |
| `mb_dialog_next_button` | Siguiente |
| `mb_dialog_skip_button` | Omitir |
| `mb_document_class_filtered_dialog_message` | Intenta escanear otro documento. |
| `mb_document_class_filtered_dialog_title` | Documento no admitido |
| `mb_document_not_fully_visible` | Mantén el documento completamente visible |
| `mb_document_too_close_to_edge` | Aleja el documento del borde |
| `mb_enable_camera` | Habilitar cámara |
| `mb_enable_permission_help` | Se abrirán los ajustes de permisos para que autorices el acceso de la aplicación a la cámara. |
| `mb_enable_permission_help_instant_app` | Autoriza el acceso a la cámara en los ajustes de permisos de la aplicación. |
| `mb_face_photo_not_fully_visible` | Mantén completamente visible la foto del rostro |
| `mb_flashlight_warning_message` | Evita los reflejos de la linterna.<br>Mueve suavemente el documento para eliminarlos. |
| `mb_front_instructions` | Escanea el frente del documento |
| `mb_glare_detected` | Inclina o mueve el documento para eliminar el reflejo |
| `mb_help_screen_barcode_msg1` | No cubras ninguna parte del código de barras con los dedos. Evita los reflejos que impidan leerlo. |
| `mb_help_screen_barcode_msg2` | Evita la luz intensa y directa, ya que puede crear reflejos en el código de barras. Si no puedes verlo con claridad, es posible que la cámara tampoco pueda leerlo. |
| `mb_help_screen_barcode_msg3` | Mantén quietos el teléfono y el código de barras durante el escaneo. El movimiento puede desenfocar la imagen y dificultar la lectura. |
| `mb_help_screen_barcode_title1` | Mantén visible el código de barras |
| `mb_help_screen_mrz_msg1` | No cubras ninguna parte de la zona de lectura mecánica con los dedos. Evita los reflejos que impidan leerla. |
| `mb_help_screen_mrz_title1` | Mantén visible la zona de lectura mecánica |
| `mb_help_screen_msg1` | No cubras los campos del documento con los dedos, incluidas las líneas inferiores. Evita los reflejos del holograma sobre la información. |
| `mb_help_screen_msg2` | Evita la luz intensa y directa, ya que puede reflejarse en el documento e impedir su lectura. Si no puedes leer la información, la cámara tampoco podrá verla. |
| `mb_help_screen_msg3` | Mantén quietos el teléfono y el documento durante el escaneo. El movimiento puede desenfocar la imagen e impedir la lectura de la información. |
| `mb_help_screen_title1` | Mantén visibles todos los campos |
| `mb_help_screen_title2` | Evita la luz intensa |
| `mb_help_screen_title3` | No te muevas durante el escaneo |
| `mb_increase_lighting_intensity` | Ubícate en un lugar más iluminado |
| `mb_instructions_mrz` | Escanea la zona de lectura mecánica |
| `mb_instructions_scan_barcode_last_page` | Escanea el código de barras de la última página |
| `mb_instructions_turn_page_left` | Pasa a la página de la izquierda |
| `mb_instructions_turn_page_right` | Pasa a la página de la derecha |
| `mb_instructions_turn_page_top` | Pasa a la página superior |
| `mb_keep_document_parallel` | Mantén el documento paralelo al teléfono |
| `mb_left_page_instructions` | Escanea la página de la izquierda |
| `mb_license_locked` | Escaneo no disponible |
| `mb_loading` | Cargando… |
| `mb_move_closer` | Acércate |
| `mb_move_farther` | Aléjate |
| `mb_mrz_id_instructions` | Escanea el lado del documento que tiene la zona de lectura mecánica |
| `mb_need_help_tooltip` | ¿Necesitas ayuda? |
| `mb_no_internet_connection` | Sin conexión a Internet |
| `mb_ok` | Aceptar |
| `mb_onboarding_dialog_barcode_id_message` | Los códigos de barras pueden tener distintos formatos y ubicaciones. Revisa el frente y el reverso del documento para encontrarlo. |
| `mb_onboarding_dialog_barcode_id_title` | Ubica el código de barras del documento |
| `mb_onboarding_dialog_barcode_message` | Busca un código de barras: una serie de líneas negras o un código cuadrado. Mantén limpio el lente de la cámara y bien iluminado el código. |
| `mb_onboarding_dialog_barcode_title` | Ubica y escanea el código de barras |
| `mb_onboarding_dialog_message` | Mantén el documento bien iluminado. Todos sus campos deben verse en la pantalla de la cámara. |
| `mb_onboarding_dialog_mrz_id_message` | Busca una secuencia larga de caracteres en la parte inferior del frente o del reverso, distribuida en dos o tres líneas y separada por símbolos (&lt;&lt; o &gt;&gt;). |
| `mb_onboarding_dialog_mrz_id_title` | Ubica la zona de lectura mecánica del documento |
| `mb_onboarding_dialog_title` | Mantén visible toda la información |
| `mb_passport_help_open_passport_subtitle` | Abre el pasaporte en la página con tu foto y datos personales. Allí aparecen tu nombre, fecha de nacimiento, número de pasaporte y otros datos de identificación. |
| `mb_passport_help_open_passport_title` | Abre el pasaporte en la página de datos |
| `mb_passport_onboarding_subtitle` | Abre el pasaporte en la página con tu foto y datos personales. Asegúrate de que esté bien iluminado y de que todos los campos sean completamente visibles. |
| `mb_passport_onboarding_title` | Abre tu pasaporte |
| `mb_passport_scan_data_page_instructions` | Escanea la página de datos del documento |
| `mb_recognition_timeout_dialog_message` | Asegúrate de que el documento esté bien iluminado, completamente visible y sin reflejos. |
| `mb_recognition_timeout_dialog_retry_button` | Reintentar |
| `mb_recognition_timeout_dialog_title` | No se pudo leer el documento |
| `mb_retry` | Reintentar |
| `mb_right_page_instructions` | Escanea la página de la derecha |
| `mb_scanning_wrong_page_left` | Pasa a la página de la izquierda |
| `mb_scanning_wrong_page_right` | Pasa a la página de la derecha |
| `mb_scanning_wrong_page_top` | Pasa a la página superior |
| `mb_scanning_wrong_side` | Voltea el documento |
| `mb_top_page_instructions` | Escanea la página superior |
| `mb_unsupported_document_message` | Escanea el frente de un documento admitido. |
| `mb_unsupported_document_title` | Documento no reconocido |
| `mb_warning` | Advertencia |

### Captura facial

| Clave | Valor de referencia en español |
| --- | --- |
| `amplify_ui_liveness_camera_permission_button_description` | Es posible que debas permitir el acceso a la cámara en los ajustes, cerrar la aplicación y volver a intentarlo. |
| `amplify_ui_liveness_camera_permission_button_header` | No se puede acceder a la cámara |
| `amplify_ui_liveness_camera_permission_button_title` | Cambiar ajustes de cámara |
| `amplify_ui_liveness_camera_permission_page_title` | Prueba de vida |
| `amplify_ui_liveness_camera_setting_alert_message` | Permite el acceso a la cámara en los ajustes. |
| `amplify_ui_liveness_camera_setting_alert_not_now_button_text` | Ahora no |
| `amplify_ui_liveness_camera_setting_alert_title` | Cambiar ajustes de cámara |
| `amplify_ui_liveness_camera_setting_alert_update_setting_button_text` | Actualizar ajustes |
| `amplify_ui_liveness_center_your_face_text` | Centra tu rostro |
| `amplify_ui_liveness_challenge_cancel_a11y` | Cancelar verificación |
| `amplify_ui_liveness_challenge_connecting` | Conectando… |
| `amplify_ui_liveness_challenge_instruction_hold_face_during_countdown` | Mantén la posición del rostro durante la cuenta regresiva. |
| `amplify_ui_liveness_challenge_instruction_hold_face_during_freshness` | Mantén el rostro dentro del óvalo durante la detección con luces de colores. |
| `amplify_ui_liveness_challenge_instruction_hold_still` | No te muevas |
| `amplify_ui_liveness_challenge_instruction_move_face_back` | Aléjate |
| `amplify_ui_liveness_challenge_instruction_move_face_closer` | Acércate |
| `amplify_ui_liveness_challenge_instruction_move_face_in_front_of_camera` | Coloca tu rostro frente a la cámara |
| `amplify_ui_liveness_challenge_instruction_multiple_faces_detected` | Solo un rostro por verificación |
| `amplify_ui_liveness_challenge_recording_indicator_label` | GRAB. |
| `amplify_ui_liveness_challenge_verifying` | Verificando |
| `amplify_ui_liveness_close_button_a11y` | Cerrar |
| `amplify_ui_liveness_face_not_prepared_reason_face_too_close` | Aleja un poco el rostro |
| `amplify_ui_liveness_face_not_prepared_reason_move_face_closer` | Acércate |
| `amplify_ui_liveness_face_not_prepared_reason_move_face_left` | Mueve el rostro hacia la izquierda |
| `amplify_ui_liveness_face_not_prepared_reason_move_face_right` | Mueve el rostro hacia la derecha |
| `amplify_ui_liveness_face_not_prepared_reason_move_to_brighter_area` | Busca un lugar más iluminado |
| `amplify_ui_liveness_face_not_prepared_reason_move_to_dimmer_area` | Busca un lugar con menos luz |
| `amplify_ui_liveness_face_not_prepared_reason_multiple_faces` | Solo un rostro por verificación |
| `amplify_ui_liveness_face_not_prepared_reason_no_face` | Coloca tu rostro frente a la cámara |
| `amplify_ui_liveness_face_not_prepared_reason_not_in_oval` | Mueve el rostro para que quede dentro del óvalo |
| `amplify_ui_liveness_face_not_prepared_reason_pendingCheck` |   |
| `amplify_ui_liveness_get_ready_begin_check` | Iniciar verificación de video |
| `amplify_ui_liveness_get_ready_page_title` | Prueba de vida |
| `amplify_ui_liveness_get_ready_photosensitivity_description` | Esta verificación muestra luces de diferentes colores. Ten precaución si eres fotosensible. |
| `amplify_ui_liveness_get_ready_photosensitivity_dialog_description` | Algunas personas pueden experimentar convulsiones epilépticas al exponerse a luces de colores intermitentes. Ten precaución si tú o alguien de tu familia presenta una condición convulsiva. |
| `amplify_ui_liveness_get_ready_photosensitivity_dialog_title` | Advertencia de fotosensibilidad |
| `amplify_ui_liveness_get_ready_photosensitivity_icon_a11y` | Información sobre fotosensibilidad |
| `amplify_ui_liveness_get_ready_photosensitivity_title` | Advertencia de fotosensibilidad |
