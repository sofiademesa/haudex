import 'monster.dart';

/// The monsters the app starts with. This is GIVEN - your app should begin by
/// showing these, and let the user add more on top.
const seedMonsters = <Monster>[
  Monster(name: 'Emberling', type: 'fire', hp: 40, maxHp: 40),
  Monster(name: 'Aquaphin', type: 'water', hp: 30, maxHp: 30),
  Monster(name: 'Sprout', type: 'grass', hp: 25, maxHp: 25),
];
