# Localization and text overrides — iOS

## Setup

1. Add [Localizable.strings](Localizable.strings) to the app target, or copy only the needed entries into its existing table.
2. Preserve key names and edit only the values.
3. Create localized variants such as `es.lproj/Localizable.strings` and `en.lproj/Localizable.strings`.
4. Rebuild the host app. `BDIVConfig` does not select a localization table.

Host-defined native keys take priority for those individual phrases. Missing keys retain the contract-assigned phrase or the SDK's default. Customize each supported locale. Updating text resources does not require rebuilding the SDK binary.

## Keys by screen

A shared key affects every screen that uses it. Copy full key names from the template; `*` below denotes a prefix, not a literal key.

| Screen or purpose | Keys |
| --- | --- |
| Introduction | `text_tittle_general_intro`, `text_sub_tittle_general_intro`, `text_selfie_intro_general`, `text_document_intr_general`, `text_start_btn` |
| Country and document selection | `text_tittle_selec_document`, `text_body_country`, `text_select_country`, `text_cancel_close`, `text_dni_selec_document`, `text_license`, `text_passport` |
| Facial introduction | `text_video_intro` |
| Document capture | `text_tittle_intro_doc_front`, `text_btn_introduction_doc` |
| Preview | `text_info_preview`, `text_confirm_preview`, `text_retry_previe` |
| Loading and upload | `text_loader_init`, `text_loading`, `text_varification_title`, `text_varification_body`, `text_varification_buttom`, `text_info_upload`, `text_info_upload_document`, `text_document_validation` |
| Result checking | `text_progress_result`, `text_progress_delay_result`, `text_progress_delay_finish_result` |
| Document error and retry | `text_title_document_error`, `text_sub_title_document_error`, `text_title_button_retry` |
| Creation and results: facial exit, recapture, retry | `identity_error_*` keys in the template. |
| General error or failed validation | `text_varification_title_error`, `text_varification_body_error`, `text_varification_title_compliance_error`, `text_varification_body_compliance_error`, `text_error_compliance_not_allowed`, `general_error`, `unknown_error` |
| Connection errors | `timeout_error`, `no_internet_error`, `connection_lost_error` |
| Permissions and privacy | `tittle_permisiions_not_aut`, `camera_error_permissions`, `text_screen_recording_not_allowed` |
| Facial error | `liveness_detection_failed`, `error_low_confidence` |
| Configuration error callback | `text_msn_error_config`, `error_clientid_empty`, `error_client_secret_empty`, `error_contractid_empty`, `error_userid_emty`, `error_vallidationtype_empty` |
| Final result | `text_finish`, `text_sub_tittle_finish`, `terminate_text` |
| Exit confirmation | `text_undo`, `text_cancel`, `text_tittle_undo`, `text_sub_tittle_undo`, `cancel_by_user` |
| Face Liveness: preparation and photosensitivity | `amplify_ui_liveness_get_ready_*` |
| Face Liveness: capture instructions | `amplify_ui_liveness_challenge_*`, `amplify_ui_liveness_face_not_prepared_reason_*`, `amplify_ui_liveness_center_your_face_text` |
| Face Liveness: permissions and exit | `amplify_ui_liveness_camera_*`, `amplify_ui_liveness_close_button_a11y` |

## Capture guidance

BlinkID UX supplies its own localized capture guidance. The `mbic_*` entries retained in the examples belong to the earlier Capture UI and do not customize BlinkID UX. Use the resources supplied by the pinned BlinkID UX dependency for its capture UI. Become's introduction, preview, and error screens use the keys above.

## Formatting and verification

- Preserve camera, accessibility, and photosensitivity instructions.
- Keep formatting placeholders and intentional line breaks. In the iOS template, preserve `%d%%` for upload progress and `%@` in facial error messages.
- In Android XML, escape `&` as `&amp;` and preserve escaped apostrophes; keep the host app's `app_name`.
- Do not rename keys to correct existing spelling or duplicate entries for a locale.
- After rebuilding the host app, verify introduction, capture, retry/error, loading, and results in every supported language on a physical device.
