## 0.1.0

* Initial release for lab #7.
* Public static API: `Flashlight.onLight()`, `Flashlight.offLight()`,
  `Flashlight.toggle()` and `Flashlight.isOn` getter.
* Android implementation via `CameraManager.setTorchMode`.
* iOS / web / desktop throw `FlashlightUnsupportedException`.
