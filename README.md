# auto_orientation_v2

[![pub package](https://img.shields.io/pub/v/auto_orientation_v2.svg)](https://pub.dev/packages/auto_orientation_v2)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.0.0-blue.svg)](https://flutter.dev)

A Flutter plugin to **programmatically control device orientation** on **iOS** and **Android**.  
This package is an improved version of the original:  
➡️ <https://pub.dev/packages/auto_orientation>

---

## 🚀 Features

- Instantly switch between Portrait, Landscape, and Auto modes.
- No need to manually call `SystemChrome.setPreferredOrientations`.
- Supports **forceSensor** on Android (overrides user's rotation settings, similar to YouTube fullscreen).
- Includes **declarative `AutoOrientationScope`** widget to auto-lock and revert orientation.
- Includes **orientation helper getters** (`isLandscape`, `isPortrait`).
- Ideal for video players, games, reading apps, and custom UI scenarios.

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  auto_orientation_v2: ^2.4.0
```

Import the package:

```dart
import 'package:auto_orientation_v2/auto_orientation_v2.dart';
```

---

## 📲 Usage

### 🎞 Landscape Modes

```dart
AutoOrientation.landscapeLeftMode();
AutoOrientation.landscapeRightMode();
```

### 📱 Portrait Modes

```dart
AutoOrientation.portraitUpMode();
AutoOrientation.portraitDownMode(); // may not work on some devices
```

### 🧭 Auto Modes (Android Only)

Follow device/user rotation preferences:

```dart
AutoOrientation.portraitAutoMode();
AutoOrientation.landscapeAutoMode();
```

Force sensor-based orientation (ignore user rotation preference):

```dart
AutoOrientation.portraitAutoMode(forceSensor: true);
AutoOrientation.landscapeAutoMode(forceSensor: true);
```

### 🔄 Full Auto Mode

Allow all orientations:

```dart
AutoOrientation.fullAutoMode();
```

---

## 🛠️ New: Enum-based API (Recommended)

Since version `2.3.8`, you can use the `setOrientation` method with the `AutoOrientationMode` enum for a cleaner syntax.

```dart
import 'package:auto_orientation_v2/auto_orientation_v2.dart';

// Switch to landscape
AutoOrientation.setOrientation(AutoOrientationMode.landscapeRight);

// Switch to portrait
AutoOrientation.setOrientation(AutoOrientationMode.portraitUp);

// Use auto mode with force sensor (Android)
AutoOrientation.setOrientation(
  AutoOrientationMode.landscapeAuto,
  forceSensor: true,
);

// Reset to user/system default
AutoOrientation.setOrientation(AutoOrientationMode.user);
```

---

## 🛡️ `AutoOrientationScope` (Declarative Widget)

Automatically lock orientation when entering a page and restore orientation when leaving:

```dart
@override
Widget build(BuildContext context) {
  return AutoOrientationScope(
    targetMode: AutoOrientationMode.landscapeRight,
    onDisposeMode: AutoOrientationMode.portraitUp,
    child: Scaffold(
      body: VideoPlayerWidget(),
    ),
  );
}
```

---

## 🔍 Orientation Helpers

Utility methods to check the current device orientation:

```dart
if (AutoOrientation.isLandscape(context)) {
  // Render landscape UI
}

if (AutoOrientation.isPortrait(context)) {
  // Render portrait UI
}

Orientation current = AutoOrientation.currentOrientation(context);
```

---

## ❗ Important Notes

- **Do NOT call `SystemChrome.setPreferredOrientations` manually.**
  The plugin manages orientation internally to avoid Android auto-rotation issues.

---

## 📘 Example

A common use case: Flutter video player fullscreen.

```dart
@override
void initState() {
  super.initState();
  AutoOrientation.landscapeRightMode(); // switch to fullscreen landscape
}

@override
void dispose() {
  AutoOrientation.portraitUpMode(); // revert to portrait when closed
  super.dispose();
}
```

More examples are available inside the `example/` folder.

---

## 📄 License

MIT License © 2025

---
