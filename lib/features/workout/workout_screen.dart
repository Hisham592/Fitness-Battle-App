import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/core/widgets/custom_neon_button.dart';
import 'package:voz_app/features/workout/achive/achivesceen.dart';
import 'package:voz_app/features/workout/data.dart';
import 'package:voz_app/features/workout/details/detail_screen.dart';
import 'package:voz_app/features/workout/exercise_datasets.dart';
import 'package:voz_app/features/workout/level_cubit/controller.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final Set<int> _completedIndices = {};
  String _lastLevel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const AppBarTitleWidget(title: "WORKOUT"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          String userLevel = 'Beginner';
          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final int xp = data['xp'] ?? 0;
            userLevel = xp >= 5000 ? 'Advanced' : (xp >= 1500 ? 'Intermediate' : 'Beginner');
          }

          if (_lastLevel.isNotEmpty && _lastLevel != userLevel) {
            _completedIndices.clear();
          }
          _lastLevel = userLevel;

          final String day = DateFormat('EEEE').format(DateTime.now());
          final Map<String, List<ExerciseData>> exercises = exercisesForLevel(userLevel);
          final String header = headerForLevel(userLevel);
          final List<ExerciseData> todayWorkout = exercises[day] ?? [];
          final bool allCompleted =
              todayWorkout.isNotEmpty &&
              _completedIndices.length == todayWorkout.length;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      header,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Rajdhani',
                      ),
                    ),
                    Text(
                      "Today's Focus: ${todayWorkout.isNotEmpty ? todayWorkout.first.primaryMuscle : 'Rest Day'}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Barlow',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todayWorkout.length,
                      itemBuilder: (context, index) {
                        final exercise = todayWorkout[index];
                        final bool isChecked = _completedIndices.contains(index);
                        final primaryColor = Theme.of(context).colorScheme.primary;

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ExerciseDetailScreen(exercise: exercise),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: isChecked
                                    ? primaryColor.withValues(alpha: 0.5)
                                    : AppColors.textSecondary.withValues(
                                        alpha: 0.2,
                                      ),
                                width: 1.w,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 54.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff11111A),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Image.asset(exercise.iconPath),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exercise.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Rajdhani',
                                        ),
                                      ),
                                      Text(
                                        "${exercise.sets} × ${exercise.reps}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Barlow',
                                        ),
                                      ),
                                      Text(
                                        "${exercise.primaryMuscle}.${exercise.secondaryMuscle}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Barlow',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      if (_completedIndices.contains(index)) {
                                        _completedIndices.remove(index);
                                      } else {
                                        _completedIndices.add(index);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(6.w),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      width: 28.w,
                                      height: 28.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isChecked
                                            ? primaryColor
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: isChecked
                                              ? primaryColor
                                              : AppColors.textSecondary.withValues(
                                                  alpha: 0.5,
                                                ),
                                          width: 2.w,
                                        ),
                                      ),
                                      child: isChecked
                                          ? Icon(
                                              Icons.check_rounded,
                                              color: Colors.black,
                                              size: 18.sp,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (context, userSnapshot) {
                        bool isCompletedToday = false;
                        if (userSnapshot.hasData && userSnapshot.data!.exists) {
                          final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                          final List<dynamic> completedDays = userData['completedDays'] ?? [];
                          final String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
                          isCompletedToday = completedDays.contains(todayStr);
                        }
                        return CustomNeonButton(
                          text: isCompletedToday
                              ? 'CHALLENGE COMPLETED'
                              : 'FINISH CHALLENGE',
                          onPressed: (allCompleted && !isCompletedToday)
                              ? () async {
                                  final result =
                                      await WorkoutProgressService.finishWorkout(
                                        todayWorkout.length,
                                      );
                                  final streak =
                                      await WorkoutProgressService.getStreak();
                                  if (context.mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AchiveScreen(
                                          xpEarned: result['xpEarned'] ?? 50,
                                          streakDays: streak,
                                        ),
                                      ),
                                    );
                                  }
                                  setState(() {
                                    challengeCompleted = true;
                                  });
                                }
                              : null,
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
