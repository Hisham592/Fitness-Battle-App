import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:intl/intl.dart';
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
  'Tuesday': [
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
  'Wednesday': [
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
  'Thursday': [
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
  @override
  Widget build(BuildContext context) {
    final todayWorkout = expertExercises[day] ?? [];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.center,
          'WORKOUT',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Rajdhani',
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 16.0.w),
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
                color: AppColors.primaryNeon,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Barlow',
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: todayWorkout.length,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14.r),
                    splashColor: AppColors.cardBackground.withValues(alpha: 0.3),
                    highlightColor:
                        AppColors.cardBackground.withValues(alpha: 0.15),
                    hoverColor:
                        AppColors.cardBackground.withValues(alpha: 0.08),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExerciseDetailScreen(
                            exercise: todayWorkout[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0.w, vertical: 8.0.h),
                      width: 336.w,
                      height: 85.h,
                      margin: EdgeInsets.symmetric(vertical: 12.0.h),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(14.0.r),
                        border: Border.all(
                          color: AppColors.textSecondary
                              .withValues(alpha: 0.2),
                          width: 1.0.w,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              width: 60.w,
                              height: 70.h,
                              decoration: const BoxDecoration(
                                color: Color(0xff11111A),
                              ),
                              child: Center(
                                child: Image.asset(
                                  todayWorkout[index].iconPath,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todayWorkout[index].name,
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                  Text(
                                    "${todayWorkout[index].sets} × ${todayWorkout[index].reps}",
                                    style: TextStyle(
                                      color: AppColors.primaryNeon,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Barlow',
                                    ),
                                  ),
                                  Text(
                                    "${todayWorkout[index].primaryMuscle}.${todayWorkout[index].secondaryMuscle}",
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
                          ]),
                          Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: AppColors.timerback,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryNeon,
                                width: 2.0.w,
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/timer icon.svg',
                                width: 13.w,
                                height: 13.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14.r),
                  onTap: challengeCompleted
                      ? null
                      : () async {
                          await WorkoutProgressService.finishWorkout();
                          final streak =
                              await WorkoutProgressService.getStreak();
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AchiveScreen(
                                  xpEarned: 50,
                                  streakDays: streak,
                                ),
                              ),
                            );
                          }
                          setState(() {
                            challengeCompleted = true;
                          });
                        },
                  child: Container(
                    width: 336.w,
                    height: 54.h,
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppColors.textSecondary
                            .withValues(alpha: 0.2),
                        width: 1.w,
                      ),
                    ),
                    child: Center(
                        child: Text(
                      challengeCompleted
                          ? 'CHALLENGE COMPLETED'
                          : 'FINISH CHALLENGE',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Rajdhani',
                      ),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ))),
    );
  }
}