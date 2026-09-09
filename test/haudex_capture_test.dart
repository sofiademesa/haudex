// m5a5 - screenshot capture (teacher-canonical, NOT scored).
//
// The capstone, so this walks the WHOLE app: the dex list, a monster's detail
// screen, an attack landing, and the add-monster form. Every shot is written
// even if an interaction fails, so a half-finished app still gets photographed
// as far as it goes.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:m5a5_haudex_app/seed.dart';
import 'package:m5a5_haudex_app/dex_app.dart';

import 'support/haudex_golden.dart';

void main() {
  setUpAll(loadHaudexFonts);

  testWidgets('capture: haudex end to end', (tester) async {
    await pumpHaudex(tester, const DexApp());
    await shoot(tester, '01-dex-list');

    final first = seedMonsters.first.name;

    await step(tester, '02-monster-detail', () async {
      await tester.tap(find.text(first).first);
    });

    await step(tester, '03-after-attack', () async {
      await tester.tap(find.widgetWithText(ElevatedButton, 'Attack'));
    });

    await step(tester, '04-back-on-list', () async {
      await tester.pageBack();
    });

    await step(tester, '05-add-monster-form', () async {
      await tester.tap(find.byType(FloatingActionButton));
    });
  });
}
