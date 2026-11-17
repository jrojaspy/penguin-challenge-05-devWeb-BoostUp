# Boost Up

Aplicación móvil de **lista de tareas con frases motivadoras**, desarrollada con Flutter y Dart para Android e iOS desde una única base de código.

> Proyecto del CodePRO Challenge 5: *"¡Atención, superhéroe del código! Boost Up te necesita para salvar el día"*.

**Autor:** Juan Rojas
**Curso / institución:** Penguin Academy
**Fecha:** 17/11/2026

---

## Funcionalidades

| # | Requisito del challenge | Cómo se cumple |
|---|---|---|
| 1 | Pantalla de bienvenida | Mensaje amigable y dos botones: **Lista de tareas** e **Inspiración diaria** |
| 2 | Lista de tareas | Pantalla con todas las tareas, botón flotante `+` para agregar y ícono de papelera para eliminar |
| 3 | Navegación | `Navigator.push` / `pop` entre bienvenida, lista, detalle de tarea e inspiración |
| 4 | Persistencia de datos | Las tareas se guardan con `SharedPreferences` y sobreviven al cierre de la app |
| 5 | Frases motivadoras | Frase aleatoria desde una lista predefinida, con botón para refrescar |
| 6 | Dispositivos reales | Proyecto configurado para compilar en Android e iOS |

## Requisitos

- **Flutter** estable (versión usada: _ejecuta `flutter --version` y anótala aquí_). Incluye Dart.
- **Android:** Android Studio con un emulador, o un teléfono con depuración USB.
- **iOS (solo en macOS):** Xcode y CocoaPods.
- Un editor: VS Code con las extensiones *Flutter* y *Dart*, o Android Studio.

Comprueba tu entorno con:

```bash
flutter doctor
```

## Cómo ejecutar el proyecto

```bash
# 1. Clona o descarga el proyecto y entra a la carpeta
cd boost_up

# 2. Descarga las dependencias
flutter pub get

# 3. Ejecuta en el emulador o dispositivo conectado
flutter run
```

Para elegir dispositivo: `flutter devices` y luego `flutter run -d <id>`.

## Estructura del proyecto

```
boost_up/
├── lib/
│   ├── main.dart                          # Punto de entrada y configuración de MaterialApp
│   ├── models/
│   │   └── tarea.dart                     # Modelo de datos con toJson / fromJson
│   ├── services/
│   │   ├── almacenamiento_tareas.dart     # Lectura y escritura con SharedPreferences
│   │   └── frases_service.dart            # Lista de frases y selección aleatoria
│   └── screens/
│       ├── bienvenida_screen.dart         # Pantalla inicial
│       ├── lista_tareas_screen.dart       # Lista, alta (FAB) y eliminación
│       ├── detalle_tarea_screen.dart      # Detalle de una tarea
│       └── inspiracion_screen.dart        # Frases motivadoras
├── test/                                  # Pruebas unitarias y de widget
├── android/                               # Proyecto nativo Android
├── ios/                                   # Proyecto nativo iOS
└── pubspec.yaml                           # Dependencias y configuración
```

### Flujo de navegación

```
PantallaBienvenida
   ├── PantallaListaTareas ── (al tocar una tarea) ──► PantallaDetalleTarea
   └── PantallaInspiracion
```

### Flujo de datos de las tareas

```
 initState ──► cargar() ──► lista en memoria ──► pantalla
 agregar / eliminar / completar ──► setState ──► guardar() ──► SharedPreferences
```

## Pruebas

```bash
flutter analyze    # análisis estático
flutter test       # pruebas automáticas
```

Las pruebas cubren: el modelo (`toJson` / `fromJson`), el almacenamiento (guardar, cargar, eliminar y datos corruptos), la navegación entre pantallas, la lista de tareas (agregar, validar y eliminar), el detalle y las frases (sin repetición consecutiva y botón de refrescar).

## Compilar para dispositivos reales

### Android

```bash
flutter build apk --release
```

El APK queda en `build/app/outputs/flutter-apk/app-release.apk`. Para instalarlo en un dispositivo o emulador conectado:

```bash
flutter install
```

Para publicar en Google Play se necesita además un App Bundle firmado (`flutter build appbundle --release`) con una clave propia. Consulta la [guía oficial de Android](https://docs.flutter.dev/deployment/android).

### iOS (requiere macOS)

```bash
open ios/Runner.xcworkspace          # configurar Team y Bundle Identifier en Xcode
flutter run -d <id-del-simulador>    # probar en simulador o iPhone
flutter build ios --no-codesign      # verificar que compila
```

Pasos en Xcode: *Runner → Signing & Capabilities*, elegir el *Team* y un *Bundle Identifier* único. Consulta la [guía oficial de iOS](https://docs.flutter.dev/deployment/ios).

> Si desarrollas en Windows o Linux, la app se programa y prueba en Android; la compilación para iOS debe hacerse en una Mac.

## Decisiones técnicas

- **Lista local de frases en vez de API:** el enunciado permite ambas opciones. La lista local funciona sin internet, no depende de servicios de terceros y no requiere permisos adicionales.
- **Un único texto JSON en SharedPreferences:** `SharedPreferences` solo guarda tipos simples, por lo que la lista se serializa con `jsonEncode`. La clave incluye versión (`tareas_v1`) para poder migrar el formato en el futuro.
- **Capa de servicios:** el acceso a disco y las frases viven fuera de las pantallas, lo que mantiene la interfaz simple y facilita las pruebas.
- **Estado con `setState`:** para el tamaño del proyecto no se necesita un gestor de estado. La lista de tareas vive en su pantalla y el detalle recibe la tarea por constructor.
- **Regla de persistencia:** toda modificación de la lista llama a `guardar()`; la carga ocurre en `initState`.
- **Tolerancia a fallos:** si los datos guardados están dañados, la app inicia con una lista vacía en lugar de cerrarse.

## Limitaciones conocidas

- Los datos se guardan solo en el dispositivo; no hay sincronización entre dispositivos.
- `SharedPreferences` no es adecuado para grandes volúmenes de datos.
- Las frases provienen de una lista fija.
- Si se desinstala la app, se pierden las tareas.

## Mejoras futuras

- Frases desde una API, con la lista local como respaldo sin conexión.
- Modo claro y oscuro con preferencia guardada.
- Animaciones (por ejemplo `AnimatedSwitcher` en las frases y `Hero` entre pantallas).
- Ícono personalizado de la aplicación.
- Fechas límite y recordatorios.
- Categorías y filtros de tareas.
- Base de datos local (`sqflite` o `drift`) y gestor de estado (Provider o Riverpod).

## Tecnologías

- [Flutter](https://flutter.dev) y [Dart](https://dart.dev)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- Material Design 3

## Licencia

Proyecto académico. MIT.