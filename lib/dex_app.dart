import 'package:flutter/material.dart';

import 'monster.dart';
import 'seed.dart';

/// Module 5 - Activity 5 - HAUDEX app (course capstone)
///
/// Put the whole course together into one small, complete app. `DexApp` is the
/// home experience and must:
///
///   * start by showing the [seedMonsters] in a scrollable list (name + type),
///   * have a `FloatingActionButton` that opens a form (a dialog or a new
///     screen) with a `TextField` to add a new monster; adding it grows the
///     list (so this is a `StatefulWidget`),
///   * let the user tap a monster to `Navigator.push` a DETAIL screen for it,
///     which shows the type in a `Text` keyed `Key('detailType')`, the current
///     HP in a `Text` keyed `Key('hp')`, and an `ElevatedButton` labelled
///     `Attack` that lowers that monster's HP with `setState` (never below 0).
///
/// Then make it feel like a real app: consistent styling, a good add flow, and
/// a detail screen with some battle feedback (an HP bar, a fainted state).
/// Split it into small widgets/files - do not cram everything into one build.
///
/// This is graded on how complete and polished it is (see `RUBRIC.md`), not just
/// on passing the checks.
class DexApp extends StatefulWidget {
  const DexApp({super.key});

  @override
  State<DexApp> createState() => _DexAppState();
}

class _DexAppState extends State<DexApp> {
  // TODO: hold the list of monsters in state, seeded from seedMonsters.

  @override
  Widget build(BuildContext context) {
    // TODO: a Scaffold with the monster list, a FloatingActionButton to add,
    // and tapping a monster navigates to its detail screen.
    return Scaffold(
      appBar: AppBar(title: const Text('HAUDEX')),
      body: const Center(child: Text('TODO: build the HAUDEX app')),
    );
  }
}
