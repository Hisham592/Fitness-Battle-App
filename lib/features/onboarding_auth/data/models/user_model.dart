class UserModel {
  final String uid;
  final String name;
  final String email;
  final String level;
  final int xp;
  final int points;
  final String createdAt;
  final int streak;
  final String lastCompletedDate;
  final List<String> completedDays;
  final String activeAvatar;
  final List<String> unlockedAvatars;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.level,
    int? xp,
    this.points = 0,
    String? createdAt,
    this.streak = 0,
    this.lastCompletedDate = "",
    this.completedDays = const [],
    this.activeAvatar = "🦁",
    this.unlockedAvatars = const ["🦁", "lion"],
  }) : xp = xp ?? _calculateInitialXp(level),
       createdAt = createdAt ?? DateTime.now().toIso8601String();

  static int _calculateInitialXp(String level) {
    switch (level.toLowerCase()) {
      case 'intermediate':
        return 1500;
      case 'advanced':
        return 5000;
      case 'beginner':
      default:
        return 0;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'level': level,
      'xp': xp,
      'points': points,
      'createdAt': createdAt,
      'streak': streak,
      'lastCompletedDate': lastCompletedDate,
      'completedDays': completedDays,
      'activeAvatar': activeAvatar,
      'unlockedAvatars': unlockedAvatars,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final int currentXp = map['xp'] ?? 0;
    String dynamicLevel = 'Beginner';

    if (currentXp >= 5000) {
      dynamicLevel = 'Advanced';
    } else if (currentXp >= 1500) {
      dynamicLevel = 'Intermediate';
    }

    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      level: dynamicLevel,
      xp: currentXp,
      points: map['points'] ?? 0,
      createdAt: map['createdAt'] ?? '',
      streak: map['streak'] ?? 0,
      lastCompletedDate: map['lastCompletedDate'] ?? '',
      completedDays: map['completedDays'] != null
          ? List<String>.from(map['completedDays'])
          : [],
      activeAvatar: map['activeAvatar'] ?? '🦁',
      unlockedAvatars: map['unlockedAvatars'] != null
          ? List<String>.from(map['unlockedAvatars'])
          : ['🦁', 'lion'],
    );
  }
}
