# Idioma y textos locales opcionales — iOS

## Integración habitual

Los textos de las pantallas de Become se aplican automáticamente según el contrato. **No necesitas agregar `Localizable.strings` ni copiar la plantilla para usar la SDK o recibir cambios de textos del contrato.**

Esta guía se conserva para personalizaciones locales puntuales, mensajes nativos y componentes de captura. La [plantilla de recursos](Localizable.strings) es una referencia de compatibilidad, no un paso de instalación ni un catálogo de todas las frases de las pantallas actuales.

## Cuándo usar recursos locales

| Necesidad | Dónde se define |
| --- | --- |
| Textos habituales del recorrido, títulos, instrucciones y acciones de Become | Configuración del contrato, por idioma. |
| Cambiar deliberadamente una frase de pantalla desde la app | Una entrada compatible en `Localizable.strings` del target de la app. |
| Mensajes nativos, como la carga inicial o ciertos errores | La clave nativa que consume ese mensaje. |
| Instrucciones internas de captura documental o del detector facial | Los recursos de localización propios del componente y de su versión. |

Un override local tiene prioridad para esa clave y puede ocultar una actualización posterior del contrato. Si ya copiaste la plantilla completa, elimina de la app las entradas que no quieras mantener como overrides; conserva las que sí necesites.

## Precedencia y selección del idioma

Las claves de pantalla compatibles se resuelven individualmente: **override de la app → texto del contrato para el locale actual → idioma base → español → valor predeterminado de la SDK**. Una clave ausente no reemplaza las demás. La SDK obtiene el locale del entorno iOS; `BDIVConfig` no expone un parámetro para seleccionar idioma ni una tabla de traducciones.

Para las pantallas actuales se admiten identificadores `namespace.clave`, por ejemplo `intro.title`, `intro.cta`, `atdp.checkboxLabel` o `countrySelection.searchPlaceholder`. Solo afectan a las frases que leen esas claves.

Algunos alias históricos siguen admitidos, como `text_tittle_general_intro` para `intro.title`, y los alias `atdp_` con formato snake case. Otras entradas antiguas de la plantilla pertenecen a pantallas reemplazadas y no controlan las vistas SwiftUI actuales. Usa la clave de pantalla específica cuando esté disponible.

## Ejemplo opcional

Agrega **solo las entradas que quieras fijar desde la app** a su `Localizable.strings`:

```text
"intro.cta" = "Empezar verificación";
"countrySelection.searchPlaceholder" = "Buscar país emisor…";
"text_loader_init" = "Cargando…";
"identity_error_documentFront" = "Vuelve a capturar el frente completo y enfocado.";
```

Las dos primeras son claves de pantalla. Las otras son claves nativas para carga y error. Incluye el archivo en el target y crea variantes como `es.lproj/Localizable.strings` o `en.lproj/Localizable.strings` únicamente para los idiomas que personalices. Los cambios locales requieren recompilar la app; no requieren regenerar el XCFramework.

## Componentes nativos

BlinkID UX incluye sus propias instrucciones localizadas y admite las claves compatibles de su versión. Las entradas `mbic_*` de las plantillas corresponden a Capture legacy y no personalizan BlinkID UX.

Amplify Face Liveness consulta sus claves compatibles `amplify_ui_liveness_*` en la app y conserva sus propios valores predeterminados cuando no hay override. Las instrucciones internas del detector y los textos de la pantalla de introducción facial se personalizan de forma independiente; el texto del contrato no se mapea automáticamente a todas las frases internas del componente.

## Verificación

Conserva nombres, mayúsculas y marcadores de formato, como `%d%%` o `%@` cuando existan en la clave original. Las rutas nativas de formato pueden descartar un override incompatible. Prueba los cambios locales en cada idioma y confirma que las claves sin override siguen mostrando el texto del contrato o su valor predeterminado. La validación funcional en dispositivo físico la realiza la app integradora.
