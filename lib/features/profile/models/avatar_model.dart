/// Represents a single purchasable/unlockable avatar in the Avatar Store.
class AvatarModel {
  final String id;
  final String name;
  final String emoji;
  final int cost;
  bool unlocked;

  AvatarModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.cost,
    this.unlocked = false,
  });
}
