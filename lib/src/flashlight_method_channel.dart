import 'dart:io' show Platform;

import 'package:flashlight_plugin/src/flashlight_platform_interface.dart';
import 'package:flashlight_plugin/src/flashlight_unsupported_exception.dart';
import 'package:flutter/services.dart';

/// MethodChannel based [FlashlightPlatform] implementation.
///
/// Per lab requirements, the channel is wired up only for Android — any
/// other platform throws [FlashlightUnsupportedException], allowing the
/// host application to display a warning dialog.
class MethodChannelFlashlight extends FlashlightPlatform {
  static const MethodChannel _channel = MethodChannel(
    'com.maksymkutsil.flashlight_plugin/flashlight',
  );

  @override
  Future<void> setTorch({required bool enabled}) async {
    if (!Platform.isAndroid) {
      throw FlashlightUnsupportedException(Platform.operatingSystem);
    }
    await _channel.invokeMethod<void>(enabled ? 'turnOn' : 'turnOff');
  }
}
