// HAUDEX golden-capture support (teacher-canonical, overlaid onto each clone).
//
// This is how a Flutter activity produces the mobile screenshots the AI design
// feedback looks at - the Flutter mirror of the web "render a preview" step.
// It is NOT a pixel-comparison test: the grade sweep runs `flutter test
// --update-goldens`, so a capture simply WRITES the PNG (it never fails on
// pixels). Behaviour is scored by the ordinary widget tests; this only takes
// the pictures.
//
// A capture test walks the app the way a user would - open a screen, tap,
// type, navigate - and shoots a frame at each interesting state, so the
// feedback sees the whole flow instead of only the first screen. Shots are
// named `01-...`, `02-...` so the sweep's sorted file order is the flow order.
//
// Three details make the screenshots look real in headless CI:
//   1. A real font is loaded (without it, `flutter test` renders every glyph as
//      a black box). Roboto-Regular.ttf is bundled next to this file and mapped
//      onto the default family so Text renders normally.
//   2. The screen is wrapped in a `device_frame` phone bezel at a phone surface
//      size, so the capture is a believable mobile preview.
//   3. The student's screen gets its OWN MaterialApp INSIDE the frame, so
//      pushed routes, dialogs and snackbars render inside the phone instead of
//      escaping to a full-window overlay the camera cannot see.
//
// Students never see this file; it is added to the clone by the grade sweep.
import 'dart:io';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'style_advisories.dart';

/// The phone we simulate for every screenshot.
final DeviceInfo kHaudexDevice = Devices.ios.iPhone13;

/// Load the fonts once so Text (and icons) render as real glyphs, not boxes.
Future<void> loadHaudexFonts() async {
  // 1. Text: the bundled Roboto, mapped onto every family Material asks for.
  final bytes = File('test/support/Roboto-Regular.ttf').readAsBytesSync();
  for (final family in ['Roboto', 'packages/device_frame/Roboto']) {
    final loader = FontLoader(family)
      ..addFont(Future.value(ByteData.view(bytes.buffer)));
    await loader.load();
  }

  // 2. Material icons: not bundled (the .otf is large), so we load it from the
  //    Flutter SDK if we can find it - both CI (subosito/flutter-action sets
  //    FLUTTER_ROOT) and a normal install ship it. Best-effort: if it is not
  //    found, icons render as boxes but text is unaffected.
  final root = Platform.environment['FLUTTER_ROOT'];
  final candidates = <String?>[
    if (root != null) '$root/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
    // Derive the SDK root from the running dart binary (.../flutter/bin/cache/dart-sdk/bin/dart).
    _deriveMaterialIconsPath(Platform.resolvedExecutable),
  ];
  for (final path in candidates) {
    if (path != null && File(path).existsSync()) {
      final iconBytes = File(path).readAsBytesSync();
      await (FontLoader('MaterialIcons')
            ..addFont(Future.value(ByteData.view(iconBytes.buffer))))
          .load();
      break;
    }
  }
}

String? _deriveMaterialIconsPath(String dartExe) {
  final marker = '/bin/cache/dart-sdk/';
  final i = dartExe.indexOf(marker);
  if (i < 0) return null;
  final flutterRoot = dartExe.substring(0, i);
  return '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf';
}

ThemeData _haudexTheme() => ThemeData(fontFamily: 'Roboto', useMaterial3: true);

/// Mount [screen] inside the phone frame, ready to be interacted with and shot.
///
/// The screen gets its own MaterialApp inside the frame so that anything it
/// pushes (a detail route, a dialog) stays inside the phone. Call this once at
/// the start of a capture flow, then use [shoot] and [step].
Future<void> pumpHaudex(WidgetTester tester, Widget screen) async {
  ignoreStyleAdvisories();

  // 390x844 logical (iPhone-ish) at dpr 2: sharp enough to read every label,
  // small enough that a five-shot flow per student stays a few hundred KB.
  tester.view.physicalSize = const Size(780, 1688);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _haudexTheme(),
      // The frame goes AROUND the app's Navigator (not around a nested
      // MaterialApp), so there is exactly one Navigator and it lives inside the
      // phone. That is what keeps pushed routes AND root-navigator overlays -
      // showDialog, bottom sheets, snackbars - inside the picture.
      builder: (context, child) =>
          DeviceFrame(device: kHaudexDevice, screen: child!),
      home: screen,
    ),
  );
  await tester.pumpAndSettle();
}

/// Write the CURRENT frame as `screenshots/<name>.png`.
///
/// Name shots `01-home`, `02-detail`, ... so the grade sweep (which sorts the
/// files) hands the feedback the flow in the order it happened.
Future<void> shoot(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
  await expectLater(
    find.byType(DeviceFrame),
    matchesGoldenFile('screenshots/$name.png'),
  );
}

/// Run [body] (a tap, some typing, a navigation) and then shoot the result.
///
/// A failure inside [body] is swallowed and reported on stdout: a student whose
/// Attack button is missing should still keep the screenshots taken before it,
/// and the steps after it still get a chance to run. Nothing here is scored.
Future<void> step(
  WidgetTester tester,
  String name,
  Future<void> Function() body,
) async {
  try {
    await body();
    await tester.pumpAndSettle();
  } catch (e) {
    // ignore: avoid_print
    print('capture: step "$name" could not run ($e); shooting current state');
  }
  try {
    await shoot(tester, name);
  } catch (e) {
    // ignore: avoid_print
    print('capture: step "$name" could not be photographed ($e)');
  }
}

/// Mount [screen] in the phone frame and take a single screenshot of it.
///
/// The one-screen shorthand for [pumpHaudex] + [shoot]. Call it from a
/// `testWidgets` whose description starts with `capture:` so the grade sweep
/// excludes it from the scored test count.
Future<void> captureScreen(
  WidgetTester tester,
  Widget screen, {
  required String name,
}) async {
  await pumpHaudex(tester, screen);
  await shoot(tester, name);
}
