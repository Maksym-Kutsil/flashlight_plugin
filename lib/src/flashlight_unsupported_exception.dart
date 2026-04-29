/// Thrown by the plugin when the host platform does not implement
/// the flashlight method channel (e.g. iOS, web, desktop).
///
/// Apps are expected to catch this exception and show an appropriate
/// notice to the user — the requirement of lab #7 is to inform the
/// user via a dialog, not to crash silently.
class FlashlightUnsupportedException implements Exception {
  const FlashlightUnsupportedException(this.platformName);

  /// The lower-case operating system identifier reported by the
  /// runtime, e.g. `'ios'`, `'macos'`, `'windows'`.
  final String platformName;

  @override
  String toString() =>
      'FlashlightUnsupportedException: flashlight is not supported '
      'on "$platformName". Native logic is implemented for Android only.';
}
