import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'dex_app.dart';

// Entry point. Run it to use your HAUDEX app on a phone. Your work is spread
// across the files in lib/ - start from `dex_app.dart`.
void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const HaudexApp(),
    ),
  );
}

class HaudexApp extends StatelessWidget {
  const HaudexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HAUDEX',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const DexApp(),
    );
  }
}
