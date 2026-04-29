import 'package:flashlight_plugin/flashlight_plugin.dart';
import 'package:flashlight_plugin/src/flashlight_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class _FakeFlashlightPlatform extends FlashlightPlatform
    with MockPlatformInterfaceMixin {
  bool? lastEnabled;
  int callCount = 0;

  @override
  Future<void> setTorch({required bool enabled}) async {
    lastEnabled = enabled;
    callCount += 1;
  }
}

void main() {
  late _FakeFlashlightPlatform fake;

  setUp(() {
    fake = _FakeFlashlightPlatform();
    FlashlightPlatform.instance = fake;
  });

  test('Flashlight.onLight forwards true to the platform', () async {
    await Flashlight.onLight();

    expect(fake.lastEnabled, isTrue);
    expect(Flashlight.isOn, isTrue);
  });

  test('Flashlight.offLight forwards false to the platform', () async {
    await Flashlight.offLight();

    expect(fake.lastEnabled, isFalse);
    expect(Flashlight.isOn, isFalse);
  });

  test('Flashlight.toggle flips state on every invocation', () async {
    await Flashlight.offLight();
    expect(Flashlight.isOn, isFalse);

    await Flashlight.toggle();
    expect(fake.lastEnabled, isTrue);
    expect(Flashlight.isOn, isTrue);

    await Flashlight.toggle();
    expect(fake.lastEnabled, isFalse);
    expect(Flashlight.isOn, isFalse);

    expect(fake.callCount, 3);
  });
}
