import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool challengeCompleted = false;
class WorkoutProgressService {
  static const _xpKey = "totalXP";
  static const _streakKey = "streak";
  static const _lastDateKey = "lastCompletedDate";
  static const _completedKey = "challengeCompletedToday";

  static Future<void> initialize() async {
  final prefs = await SharedPreferences.getInstance();

  final lastDate = prefs.getString(_lastDateKey);

  if (lastDate != null) {
    final last = DateTime.parse(lastDate);
    final now = DateTime.now();

    final difference = now.difference(last).inDays;

    if (difference == 1) {
      await prefs.setBool(_completedKey, false);
    } else if (difference > 1) {
      await prefs.setInt(_streakKey, 0);
      await prefs.setBool(_completedKey, false);
    }
  }

  challengeCompleted = prefs.getBool(_completedKey) ?? false;
}

  static Future<bool> canFinishToday() async {
    final prefs = await SharedPreferences.getInstance();

    return !(prefs.getBool(_completedKey) ?? false);
  }

  static Future<void> finishWorkout() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getBool(_completedKey) ?? false) {
    return;
  }

  final xp = prefs.getInt(_xpKey) ?? 0;
  final streak = prefs.getInt(_streakKey) ?? 0;

  await prefs.setInt(_xpKey, xp + 50);
  await prefs.setInt(_streakKey, streak + 1);
  await prefs.setBool(_completedKey, true);
  await prefs.setString(
    _lastDateKey,
    DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
}
  static Future<int> getXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_xpKey) ?? 0;
  }

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 0;
  }
}