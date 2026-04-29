import 'package:flashlight_plugin/flashlight_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const FlashlightExampleApp());
}

class FlashlightExampleApp extends StatefulWidget {
  const FlashlightExampleApp({super.key});

  @override
  State<FlashlightExampleApp> createState() => _FlashlightExampleAppState();
}

class _FlashlightExampleAppState extends State<FlashlightExampleApp> {
  bool _isOn = false;
  String? _errorMessage;

  Future<void> _toggle() async {
    try {
      await Flashlight.toggle();
      setState(() {
        _isOn = Flashlight.isOn;
        _errorMessage = null;
      });
    } on FlashlightUnsupportedException catch (error) {
      setState(() => _errorMessage = error.toString());
    } on PlatformException catch (error) {
      setState(() => _errorMessage = 'Native error: ${error.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flashlight plugin example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isOn ? Icons.flashlight_on : Icons.flashlight_off,
                size: 96,
              ),
              const SizedBox(height: 16),
              Text('Flashlight is ${_isOn ? 'ON' : 'OFF'}'),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _toggle,
                icon: const Icon(Icons.power_settings_new),
                label: const Text('Toggle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
