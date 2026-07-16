class UserModel {
  final String uid;
  final String name;
  final String email;
  final String level;
  final int xp;
  final int points;
  final String createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.level,
    int? xp,
    this.points = 0,
    String? createdAt,
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
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      level: map['level'] ?? 'Beginner',
      xp: map['xp'] ?? 0,
      points: map['points'] ?? 0,
      createdAt: map['createdAt'] ?? '',
    );
  }
}
