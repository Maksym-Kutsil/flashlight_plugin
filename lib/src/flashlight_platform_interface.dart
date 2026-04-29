import 'package:flashlight_plugin/src/flashlight_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Platform interface for the flashlight plugin.
///
/// Mocking this class in tests should be done by extending it
/// (the `verifyToken` mechanism prevents `implements`).
abstract class FlashlightPlatform extends PlatformInterface {
  FlashlightPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlashlightPlatform _instance = MethodChannelFlashlight();

  static FlashlightPlatform get instance => _instance;

  static set instance(FlashlightPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Switches the torch [enabled] state. Implementations must throw
  /// `FlashlightUnsupportedException` when the underlying platform
  /// has no native code attached.
  Future<void> setTorch({required bool enabled}) {
    throw UnimplementedError('setTorch() has not been implemented.');
  }
}
