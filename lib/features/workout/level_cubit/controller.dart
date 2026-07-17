import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voz_app/features/workout/exercise_datasets.dart';

bool challengeCompleted = false;

class WorkoutProgressService {
  static const _completedKey = "challengeCompletedToday";

  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final String lastDate = data['lastCompletedDate'] ?? '';
      final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      if (lastDate == today) {
        challengeCompleted = true;
        await prefs.setBool(_completedKey, true);
        return;
      }
    }
    challengeCompleted = false;
    await prefs.setBool(_completedKey, false);
  }

  static Future<bool> canFinishToday() async {
    return !challengeCompleted;
  }

  static Future<Map<String, int>> finishWorkout(int exerciseCount) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final int reward = exerciseCount * 10;

    if (uid == null) {
      return {'xpEarned': reward, 'streak': 1};
    }

    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final docSnapshot = await userRef.get();
    final data = docSnapshot.data() ?? {};

    final int currentStreak = data['streak'] ?? 0;
    final String lastCompletedDate = data['lastCompletedDate'] ?? '';

    final now = DateTime.now();
    final String todayStr = DateFormat('yyyy-MM-dd').format(now);

    int newStreak = currentStreak;

    if (lastCompletedDate.isEmpty) {
      newStreak = 1;
    } else if (lastCompletedDate == todayStr) {
      newStreak = currentStreak > 0 ? currentStreak : 1;
    } else {
      final lastDate = DateTime.tryParse(lastCompletedDate);
      if (lastDate == null) {
        newStreak = 1;
      } else {
        bool skippedTrainingDay = false;
        DateTime checkDate = DateTime(lastDate.year, lastDate.month, lastDate.day).add(const Duration(days: 1));
        final todayDateOnly = DateTime(now.year, now.month, now.day);

        while (checkDate.isBefore(todayDateOnly)) {
          final dayName = DateFormat('EEEE').format(checkDate);
          final exercisesForDay = beginnerExercises[dayName] ?? [];
          if (exercisesForDay.isNotEmpty) {
            skippedTrainingDay = true;
            break;
          }
          checkDate = checkDate.add(const Duration(days: 1));
        }

        if (skippedTrainingDay) {
          newStreak = 1;
        } else {
          newStreak = currentStreak + 1;
        }
      }
    }

    await userRef.update({
      'xp': FieldValue.increment(reward),
      'points': FieldValue.increment(reward),
      'completedDays': FieldValue.arrayUnion([todayStr]),
      'lastCompletedDate': todayStr,
      'streak': newStreak,
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completedKey, true);
    challengeCompleted = true;

    return {'xpEarned': reward, 'streak': newStreak};
  }

  static Future<int> getXP() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return 0;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return (doc.data()?['xp'] as num?)?.toInt() ?? 0;
  }

  static Future<int> getStreak() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return 0;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return (doc.data()?['streak'] as num?)?.toInt() ?? 0;
  }
}