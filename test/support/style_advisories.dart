// Teacher-canonical: keep Flutter's debug-only STYLING advisories from failing a
// graded test. Overlaid onto each clone by the grade sweep.
//
// Flutter 3.44 added an assert inside ListTile that REPORTS a FlutterError when
// the tile sits inside a Container or DecoratedBox that has a background colour:
// a ListTile paints its background and ink splashes on the nearest Material
// ancestor, so the coloured wrapper hides them. That is advice about a cosmetic
// detail. The app compiles and runs fine. But flutter_test counts every reported
// FlutterError as an unexpected exception, so a student who gave each row a
// coloured card failed EVERY test in the file, including the ones that never
// touch the list.
//
// The filter has to be installed from INSIDE the test body. The test binding
// installs its own FlutterError.onError for each test, which overwrites anything
// set from a flutter_test_config.dart hook or a setUp callback (both were tried
// and neither survives). So every pump helper calls ignoreStyleAdvisories()
// first.
//
// Deliberately narrow. Only the exact advisories listed here are dropped, and
// they are dropped BEFORE the binding records them, so a real failure is still
// the test's first and reported exception.
import 'package:flutter/foundation.dart';

const List<String> kStyleAdvisories = <String>[
  'ListTile background color or ink splashes may be invisible',
];

/// Silence the cosmetic advisories in [kStyleAdvisories] for the current test.
void ignoreStyleAdvisories() {
  final FlutterExceptionHandler? original = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kStyleAdvisories.any(details.exception.toString().contains)) return;
    original?.call(details);
  };
}
