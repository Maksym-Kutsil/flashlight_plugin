import 'dart:io' show Platform;

import 'package:flashlight_plugin/flashlight_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Flashlight.onLight / offLight succeed on Android, throw elsewhere',
    (tester) async {
      if (Platform.isAndroid) {
        await Flashlight.onLight();
        expect(Flashlight.isOn, isTrue);
        await Flashlight.offLight();
        expect(Flashlight.isOn, isFalse);
      } else {
        await expectLater(
          Flashlight.onLight,
          throwsA(isA<FlashlightUnsupportedException>()),
        );
      }
    },
  );
}
