/// Holds the user-specific progress stats shown on the Profile screen
/// (Active Days / streak, Total Points, Workouts, User Level).
class UserProfileModel {
  String name;
  String levelLabel; // e.g. "Level 1 Beginner"
  int memberSinceYear;
  int streakDays; // Active Days
  int totalPoints; // Total Points (PTS) - global currency balance
  int workoutsDone;
  String levelTier; // e.g. "BEGINNER"
  String activeAvatarId;

  UserProfileModel({
    required this.name,
    required this.levelLabel,
    required this.memberSinceYear,
    required this.streakDays,
    required this.totalPoints,
    required this.workoutsDone,
    required this.levelTier,
    required this.activeAvatarId,
  });
}
