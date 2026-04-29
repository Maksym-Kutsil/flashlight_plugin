# flashlight_plugin

A small Flutter plugin that controls the device flashlight (the LED next to the
camera) from Dart through a platform method channel. Created for lab #7 of the
Flutter course at KPI.

Native logic is implemented for **Android only**. On every other platform the
plugin throws a `FlashlightUnsupportedException` so the host app can react —
for example by showing a warning dialog.

## Public API

The API is fully static — it can be invoked without instantiating anything:

```dart
import 'package:flashlight_plugin/flashlight_plugin.dart';

await Flashlight.onLight();   // turn the torch on
await Flashlight.offLight();  // turn the torch off
await Flashlight.toggle();    // flip the current state
final lit = Flashlight.isOn;  // last cached state
```

## Adding to a Flutter app

Reference the plugin directly from this Git repository in your `pubspec.yaml`:

```yaml
dependencies:
  flashlight_plugin:
    git:
      url: https://github.com/Maksym-Kutsil/flashlight_plugin.git
      ref: main
```

Then run `flutter pub get`.

## Handling unsupported platforms

```dart
try {
  await Flashlight.toggle();
} on FlashlightUnsupportedException catch (error) {
  // Show an alert dialog – the lab requires informing the user.
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Not supported'),
      content: Text(error.toString()),
    ),
  );
}
```

## Android details

The plugin uses `CameraManager.setTorchMode` from the Camera2 API, which does
not require the `CAMERA` runtime permission. A `<uses-feature>` entry for
`android.hardware.camera.flash` is declared in the plugin manifest.

## License

MIT — see `LICENSE`.
