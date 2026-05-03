## 0.1.1

* Relax Dart SDK lower bound to `^3.11.0` so the package resolves on Flutter
  toolchains that ship Dart 3.11.0 (matches typical app `environment`).

## 0.1.0

* Initial release for lab #7.
* Public static API: `Flashlight.onLight()`, `Flashlight.offLight()`,
  `Flashlight.toggle()` and `Flashlight.isOn` getter.
* Android implementation via `CameraManager.setTorchMode`.
* iOS / web / desktop throw `FlashlightUnsupportedException`.
