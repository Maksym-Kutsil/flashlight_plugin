import Flutter
import UIKit

/// iOS host stub for `flashlight_plugin`.
///
/// Lab #7 explicitly scopes native code to Android, so this
/// implementation deliberately reports `FlutterMethodNotImplemented`
/// for every call. The Dart layer detects the platform first and
/// throws `FlashlightUnsupportedException` before invoking the
/// channel, so this stub is only a safety net.
public class FlashlightPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "com.maksymkutsil.flashlight_plugin/flashlight",
      binaryMessenger: registrar.messenger()
    )
    let instance = FlashlightPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(FlutterMethodNotImplemented)
  }
}
