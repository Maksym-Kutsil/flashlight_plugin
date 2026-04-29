import 'package:flashlight_plugin/src/flashlight_platform_interface.dart';
import 'package:flashlight_plugin/src/flashlight_unsupported_exception.dart';

export 'package:flashlight_plugin/src/flashlight_unsupported_exception.dart';

/// Public façade for the flashlight plugin.
///
/// All methods are intentionally `static` so the lab requirement
/// `Flashlight.onLight()` is satisfied without the caller ever
/// instantiating the class.
class Flashlight {
  const Flashlight._();

  static bool _isOn = false;

  /// Whether the torch is currently believed to be on.
  ///
  /// The value is cached on the Dart side and updated after every
  /// successful call to the native layer.
  static bool get isOn => _isOn;

  /// Turns the device flashlight ON.
  ///
  /// Throws [FlashlightUnsupportedException] when the host platform
  /// has no native implementation (e.g. iOS, web, desktop).
  static Future<void> onLight() async {
    await FlashlightPlatform.instance.setTorch(enabled: true);
    _isOn = true;
  }

  /// Turns the device flashlight OFF.
  ///
  /// Throws [FlashlightUnsupportedException] when the host platform
  /// has no native implementation.
  static Future<void> offLight() async {
    await FlashlightPlatform.instance.setTorch(enabled: false);
    _isOn = false;
  }

  /// Toggles the flashlight based on the cached [isOn] value.
  static Future<void> toggle() async {
    if (_isOn) {
      await offLight();
    } else {
      await onLight();
    }
  }
}
