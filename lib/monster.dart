/// A HAUDEX creature. This model is GIVEN - you do not need to change it.
/// (In Module 3 you built the battle logic; here you build the UI around data
/// like this.)
class Monster {
  final String name;
  final String type; // 'fire', 'water', or 'grass'
  final int hp;
  final int maxHp;

  const Monster({
    required this.name,
    required this.type,
    required this.hp,
    required this.maxHp,
  });
}
