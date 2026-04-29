import 'package:flashlight_plugin_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Example app renders the toggle button', (tester) async {
    await tester.pumpWidget(const FlashlightExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Flashlight is OFF'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Toggle'), findsOneWidget);
  });
}
