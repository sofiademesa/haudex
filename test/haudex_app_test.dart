// m5a5 - HAUDEX app (capstone): automated structural checks (canonical overlay).
// The design/UX half is judged by the instructor from the screenshot and code;
// these tests confirm the app's core interactions work.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/style_advisories.dart';

import 'package:m5a5_haudex_app/seed.dart';
import 'package:m5a5_haudex_app/dex_app.dart';

Future<void> pump(WidgetTester tester) async {
  ignoreStyleAdvisories();
  await tester.pumpWidget(const MaterialApp(home: DexApp()));
  await tester.pumpAndSettle();
}

int? firstInt(String? s) {
  final m = RegExp(r'\d+').firstMatch(s ?? '');
  return m == null ? null : int.parse(m.group(0)!);
}

void main() {
  test('student.json is filled in', () {
    final info = jsonDecode(File('student.json').readAsStringSync())
        as Map<String, dynamic>;
    for (final field in [
      'classCode',
      'fullName',
      'studentNumber',
      'studentEmail',
      'personalEmail',
      'githubAccount',
    ]) {
      expect(info[field], isNotEmpty, reason: 'Set "$field" in student.json');
    }
  });

  group('HAUDEX app', () {
    testWidgets('lists the seed monsters', (tester) async {
      await pump(tester);
      for (final m in seedMonsters) {
        expect(find.text(m.name), findsWidgets,
            reason: 'Show the seed monsters (from seed.dart) in a list.');
      }
    });

    testWidgets('has a FloatingActionButton to add a monster', (tester) async {
      await pump(tester);
      expect(find.byType(FloatingActionButton), findsOneWidget,
          reason: 'Add a FloatingActionButton for adding a monster.');
    });

    testWidgets('the add button opens a form with a TextField', (tester) async {
      await pump(tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsWidgets,
          reason: 'Tapping the add button should reveal a TextField.');
    });

    testWidgets('tapping a monster opens its detail screen', (tester) async {
      await pump(tester);
      await tester.tap(find.text(seedMonsters.first.name).first);
      await tester.pumpAndSettle();
      final f = find.byKey(const Key('detailType'));
      expect(f, findsOneWidget,
          reason:
              'Navigate to a detail screen showing the type keyed Key(\'detailType\').');
    });

    testWidgets('the detail screen has an Attack that lowers HP', (tester) async {
      await pump(tester);
      await tester.tap(find.text(seedMonsters.first.name).first);
      await tester.pumpAndSettle();
      final before = firstInt(tester.widget<Text>(find.byKey(const Key('hp'))).data);
      expect(before, isNotNull,
          reason: 'Show the current HP on the detail screen in a Text keyed Key(\'hp\').');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Attack'));
      await tester.pump();
      final after = firstInt(tester.widget<Text>(find.byKey(const Key('hp'))).data);
      expect(after! < before!, isTrue,
          reason: 'Attack should lower the HP (setState).');
      expect(after >= 0, isTrue, reason: 'HP must not go negative.');
    });
  });
}
