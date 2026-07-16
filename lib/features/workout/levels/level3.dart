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
import 'package:voz_app/features/workout/level_cubit/controller.dart';

String day = DateFormat('EEEE').format(DateTime.now());
final Map<String, List<ExerciseData>> expertExercises = {
  'Saturday': [
    ExerciseData(
      name: 'Barbell Bench Press',
      sets: 5,
      reps: 6,
      tag: 'Chest',
      description: 'Heavy compound movement focusing on maximum strength.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/hWbUlkb5Ms4?si=GO4RcUhoU89V0n0t',
    ),
    ExerciseData(
      name: 'Incline Barbell Press',
      sets: 5,
      reps: 8,
      tag: 'Chest',
      description: 'Heavy incline press for upper chest.',
      primaryMuscle: 'Upper Chest',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/98HWfiRonkE?si=t8MInuIiBk8vMU2-',
    ),
    ExerciseData(
      name: 'Weighted Dips',
      sets: 4,
      reps: 10,
      tag: 'Chest',
      description: 'Weighted bodyweight movement.',
      primaryMuscle: 'Lower Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/TZxOiJHUpyA?si=eYdfZsl2GxSlMD7E',
    ),
    ExerciseData(
      name: 'Cable Fly',
      sets: 4,
      reps: 15,
      tag: 'Chest',
      description: 'Constant tension chest isolation.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Front Shoulders',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/y4RJDSOBEl8?si=12JUobkYkRTeppIj',
    ),
    ExerciseData(
      name: 'Decline Dumbbell Press',
      sets: 4,
      reps: 10,
      tag: 'Chest',
      description: 'Focus on lower chest development.',
      primaryMuscle: 'Lower Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/8fXfwG4ftaQ?si=sbXenqt8i9W0G0Xd',
    ),
  ],
  'Sunday': [
    ExerciseData(
      name: 'Weighted Pull-ups',
      sets: 5,
      reps: 6,
      tag: 'Back',
      description: 'Weighted vertical pulling exercise.',
      primaryMuscle: 'Lats',
      secondaryMuscle: 'Biceps',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/eDP_OOhMTZ4?si=3jy4kFAy6uxiqXw_',
    ),
    ExerciseData(
      name: 'Deadlift',
      sets: 5,
      reps: 5,
      tag: 'Back',
      description: 'Heavy compound lift.',
      primaryMuscle: 'Back',
      secondaryMuscle: 'Hamstrings',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/ZaTM37cfiDs?si=F6FRyR4lB9tkEQ3O',
    ),
    ExerciseData(
      name: 'Bent Over Row',
      sets: 5,
      reps: 8,
      tag: 'Back',
      description: 'Build back thickness.',
      primaryMuscle: 'Middle Back',
      secondaryMuscle: 'Biceps',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtu.be/6FZHJGzMFEc?si=7ptwjJDoKp8Z7pss',
    ),
    ExerciseData(
      name: 'T-Bar Row',
      sets: 4,
      reps: 10,
      tag: 'Back',
      description: 'Heavy rowing movement.',
      primaryMuscle: 'Lats',
      secondaryMuscle: 'Rear Delts',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/Nm3M-4fmprk?si=BCQ3at23D3WtTHGm',
    ),
    ExerciseData(
      name: 'Straight Arm Pulldown',
      sets: 4,
      reps: 15,
      tag: 'Back',
      description: 'Lat isolation finisher.',
      primaryMuscle: 'Lats',
      secondaryMuscle: 'Core',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/hAMcfubonDc?si=5BFDJz_XQ3H53ibg',
    ),
  ],
  'Monday': [
    ExerciseData(
      name: 'Standing Military Press',
      sets: 5,
      reps: 6,
      tag: 'Shoulders',
      description: 'Heavy overhead press.',
      primaryMuscle: 'Front Delts',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/4LBVP2Oe7fg?si=vmnUORIK_2pB674c',
    ),
    ExerciseData(
      name: 'Arnold Press',
      sets: 4,
      reps: 10,
      tag: 'Shoulders',
      description: 'Full shoulder development.',
      primaryMuscle: 'Front Delts',
      secondaryMuscle: 'Side Delts',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/6K_N9AGhItQ?si=owODkQBewUlqhoPh',
    ),
    ExerciseData(
      name: 'Lateral Raise',
      sets: 5,
      reps: 15,
      tag: 'Shoulders',
      description: 'Isolation for side delts.',
      primaryMuscle: 'Side Delts',
      secondaryMuscle: 'Traps',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/f_OGBg2KxgY?si=Qp0IznSEfnYIkOvQ',
    ),
    ExerciseData(
      name: 'Face Pull',
      sets: 4,
      reps: 15,
      tag: 'Shoulders',
      description: 'Rear delt and posture.',
      primaryMuscle: 'Rear Delts',
      secondaryMuscle: 'Upper Back',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/IeOqdw9WI90?si=_y-CvccaHd101csG',
    ),
    ExerciseData(
      name: 'Barbell Shrugs',
      sets: 5,
      reps: 15,
      tag: 'Shoulders',
      description: 'Heavy trap exercise.',
      primaryMuscle: 'Traps',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/rFsSeClGnNA?si=C9roYRsZZtwe5s8v',
    ),
  ],
  'Tuesday': [],
  'Wednesday': [
    ExerciseData(
      name: 'EZ Bar Curl',
      sets: 5,
      reps: 8,
      tag: 'Arms',
      description: 'Heavy biceps curl.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/yXCFBwZ4LLU?si=FEuPtc4TLAvKEJpw',
    ),
    ExerciseData(
      name: 'Incline Dumbbell Curl',
      sets: 4,
      reps: 10,
      tag: 'Arms',
      description: 'Maximum stretch.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/fXFN8_1Bh6k?si=zQFYSRoUs037QvCR',
    ),
    ExerciseData(
      name: 'Hammer Curl',
      sets: 4,
      reps: 12,
      tag: 'Arms',
      description: 'Develop arm thickness.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtu.be/BRVDS6HVR9Q?si=nIeeFHI6E2w03gHl',
    ),
    ExerciseData(
      name: 'Close Grip Bench Press',
      sets: 5,
      reps: 8,
      tag: 'Arms',
      description: 'Heavy triceps movement.',
      primaryMuscle: 'Triceps',
      secondaryMuscle: 'Chest',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/VXJCfMES2C8?si=HhIoMJsBLwZSIpec',
    ),
    ExerciseData(
      name: 'Skull Crushers',
      sets: 4,
      reps: 12,
      tag: 'Arms',
      description: 'Triceps isolation.',
      primaryMuscle: 'Triceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/dtkD5sQLFL4?si=2cYi02acA_kxRsgc',
    ),
  ],
  'Thursday': [
    ExerciseData(
      name: 'Back Squat',
      sets: 5,
      reps: 6,
      tag: 'Legs',
      description: 'Heavy lower body compound.',
      primaryMuscle: 'Quadriceps',
      secondaryMuscle: 'Glutes',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/PPmvh7gBTi0?si=xPIRAM6-qTjbIUou',
    ),
    ExerciseData(
      name: 'Romanian Deadlift',
      sets: 5,
      reps: 8,
      tag: 'Legs',
      description: 'Hamstring dominant movement.',
      primaryMuscle: 'Hamstrings',
      secondaryMuscle: 'Glutes',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/5rIqP63yWFg?si=BfgZXWMiaefH6BwR',
    ),
    ExerciseData(
      name: 'Walking Lunges',
      sets: 4,
      reps: 20,
      tag: 'Legs',
      description: 'Improve unilateral leg strength.',
      primaryMuscle: 'Quadriceps',
      secondaryMuscle: 'Glutes',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/HIM0GrawvAU?si=O5HtPBRonRHB-D0-',
    ),
    ExerciseData(
      name: 'Leg Extension',
      sets: 4,
      reps: 15,
      tag: 'Legs',
      description: 'Quad finisher.',
      primaryMuscle: 'Quadriceps',
      secondaryMuscle: 'None',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtu.be/YyvSfVjQeL0?si=EXmH3W1GrV0qTmTa',
    ),
    ExerciseData(
      name: 'Standing Calf Raise',
      sets: 5,
      reps: 20,
      tag: 'Legs',
      description: 'Heavy calf work.',
      primaryMuscle: 'Calves',
      secondaryMuscle: 'Ankles',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/wdOkFomQNp8?si=yit0YQGkStUR4rTk',
    ),
  ],
  'Friday': [
    ExerciseData(
      name: 'Sprint Intervals',
      sets: 10,
      reps: 30,
      tag: 'Cardio',
      description: '30-second maximum effort sprints.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Legs',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/bEY-ister9w?si=w63r9xKaU0Fm5sQq',
    ),
    ExerciseData(
      name: 'Battle Ropes',
      sets: 5,
      reps: 45,
      tag: 'Cardio',
      description: 'Explosive upper body cardio.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/k3d8XozZyQQ?si=CDxQcsBSTymwSdEr',
    ),
    ExerciseData(
      name: 'Burpees',
      sets: 5,
      reps: 20,
      tag: 'Cardio',
      description: 'High intensity full body exercise.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Chest',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/zDqi7OjlQdc?si=xcfKpT3dNrl7aezg',
    ),
    ExerciseData(
      name: 'Box Jumps',
      sets: 5,
      reps: 15,
      tag: 'Cardio',
      description: 'Explosive plyometric movement.',
      primaryMuscle: 'Legs',
      secondaryMuscle: 'Core',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/HJZh-12p6vg?si=5NwFp6aI6539G4go',
    ),
    ExerciseData(
      name: 'Rowing Machine',
      sets: 1,
      reps: 30,
      tag: 'Cardio',
      description: '30 minutes high intensity rowing.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Back',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/bCxq4zMHpzs?si=XIlN3LVsIbMXiLYy',
    ),
  ],
};

class Level3WorkoutScreen extends StatefulWidget {
  const Level3WorkoutScreen({super.key});

  @override
  State<Level3WorkoutScreen> createState() => _Level3WorkoutScreenState();
}

class _Level3WorkoutScreenState extends State<Level3WorkoutScreen> {
  final Set<int> _completedIndices = {};

  @override
  Widget build(BuildContext context) {
    final todayWorkout = expertExercises[day] ?? [];
    final bool allCompleted =
        todayWorkout.isNotEmpty &&
        _completedIndices.length == todayWorkout.length;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LEVEL 3: EXPERT',
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
      ),
    );
  }
}
