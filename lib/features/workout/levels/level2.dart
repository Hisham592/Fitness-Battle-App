import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/features/workout/achive/achivesceen.dart';
import 'package:voz_app/features/workout/data.dart';
import 'package:voz_app/features/workout/details/detail_screen.dart';
import 'package:voz_app/features/workout/level_cubit/controller.dart';

String day = DateFormat('EEEE').format(DateTime.now());
final Map<String, List<ExerciseData>> intermediateExercises = {
  'Saturday': [
    ExerciseData(
      name: 'Barbell Bench Press',
      sets: 4,
      reps: 10,
      tag: 'Chest',
      description: 'Perform a full range of motion using a barbell.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/hWbUlkb5Ms4?si=GO4RcUhoU89V0n0t',
    ),
    ExerciseData(
      name: 'Incline Dumbbell Press',
      sets: 4,
      reps: 10,
      tag: 'Chest',
      description: 'Target the upper chest using dumbbells.',
      primaryMuscle: 'Upper Chest',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/8fXfwG4ftaQ?si=5f9IeJ6U5A84RL0d',
    ),
    ExerciseData(
      name: 'Cable Chest Fly',
      sets: 4,
      reps: 12,
      tag: 'Chest',
      description: 'Maintain constant tension on the chest.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Front Shoulders',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/y4RJDSOBEl8?si=92uDb95_dWPWw-2l',
    ),
    ExerciseData(
      name: 'Weighted Push-ups',
      sets: 3,
      reps: 12,
      tag: 'Chest',
      description: 'Increase resistance with added weight.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/z4oz6W1X10w?si=poXX9H6i-ED6DeWJ',
    ),
    ExerciseData(
      name: 'Chest Press Machine',
      sets: 4,
      reps: 12,
      tag: 'Chest',
      description: 'Controlled machine chest press.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/Qu7-ceCvq7w?si=ZZXfEHrA_ooojT36',
    ),
  ],
  'Sunday': [
    ExerciseData(
      name: 'Pull-ups',
      sets: 4,
      reps: 8,
      tag: 'Back',
      description: 'Bodyweight vertical pulling movement.',
      primaryMuscle: 'Lats',
      secondaryMuscle: 'Biceps',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/TZxOiJHUpyA?si=eYdfZsl2GxSlMD7E',
    ),
    ExerciseData(
      name: 'Barbell Row',
      sets: 4,
      reps: 10,
      tag: 'Back',
      description: 'Heavy rowing exercise.',
      primaryMuscle: 'Middle Back',
      secondaryMuscle: 'Biceps',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/phVtqawIgbk?si=lo3R3a5M7yYNa8T_',
    ),
    ExerciseData(
      name: 'Seated Cable Row',
      sets: 4,
      reps: 12,
      tag: 'Back',
      description: 'Controlled cable row.',
      primaryMuscle: 'Middle Back',
      secondaryMuscle: 'Rear Delts',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtu.be/GZbfZ033f74?si=Xtljwmcf7DdlMp_m',
    ),
    ExerciseData(
      name: 'Straight Arm Pulldown',
      sets: 3,
      reps: 15,
      tag: 'Back',
      description: 'Isolate the lats.',
      primaryMuscle: 'Lats',
      secondaryMuscle: 'Core',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/hAMcfubonDc?si=5BFDJz_XQ3H53ibg',
    ),
    ExerciseData(
      name: 'T-Bar Row',
      sets: 4,
      reps: 10,
      tag: 'Back',
      description: 'Build back thickness.',
      primaryMuscle: 'Back',
      secondaryMuscle: 'Biceps',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/Nm3M-4fmprk?si=BCQ3at23D3WtTHGm',
    ),
  ],
  'Monday': [
    ExerciseData(
      name: 'Standing Military Press',
      sets: 4,
      reps: 10,
      tag: 'Shoulders',
      description: 'Standing overhead press.',
      primaryMuscle: 'Front Delts',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/4LBVP2Oe7fg?si=vmnUORIK_2pB674c',
    ),
    ExerciseData(
      name: 'Lateral Raise',
      sets: 4,
      reps: 15,
      tag: 'Shoulders',
      description: 'Build wider shoulders.',
      primaryMuscle: 'Side Delts',
      secondaryMuscle: 'Traps',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/f_OGBg2KxgY?si=Qp0IznSEfnYIkOvQ',
    ),
    ExerciseData(
      name: 'Front Raise',
      sets: 3,
      reps: 12,
      tag: 'Shoulders',
      description: 'Target front delts.',
      primaryMuscle: 'Front Delts',
      secondaryMuscle: 'Upper Chest',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/h9xfpTrAvkE?si=h9wW949eiouFGnRI',
    ),
    ExerciseData(
      name: 'Face Pull',
      sets: 4,
      reps: 15,
      tag: 'Shoulders',
      description: 'Strengthen rear delts and posture.',
      primaryMuscle: 'Rear Delts',
      secondaryMuscle: 'Upper Back',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/IeOqdw9WI90?si=_y-CvccaHd101csG',
    ),
    ExerciseData(
      name: 'Barbell Shrugs',
      sets: 4,
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
      sets: 4,
      reps: 10,
      tag: 'Arms',
      description: 'Classic biceps movement.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/yXCFBwZ4LLU?si=FEuPtc4TLAvKEJpw',
    ),
    ExerciseData(
      name: 'Incline Dumbbell Curl',
      sets: 4,
      reps: 12,
      tag: 'Arms',
      description: 'Stretch-focused curl.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/fXFN8_1Bh6k?si=zQFYSRoUs037QvCR',
    ),
    ExerciseData(
      name: 'Hammer Curl',
      sets: 3,
      reps: 12,
      tag: 'Arms',
      description: 'Develop brachialis.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtu.be/BRVDS6HVR9Q?si=nIeeFHI6E2w03gHl',
    ),
    ExerciseData(
      name: 'Cable Triceps Pushdown',
      sets: 4,
      reps: 12,
      tag: 'Arms',
      description: 'Cable isolation movement.',
      primaryMuscle: 'Triceps',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/1FjkhpZsaxc?si=GidGwLJyQZrI3HwH',
    ),
    ExerciseData(
      name: 'Skull Crushers',
      sets: 4,
      reps: 10,
      tag: 'Arms',
      description: 'Build stronger triceps.',
      primaryMuscle: 'Triceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/dtkD5sQLFL4?si=2cYi02acA_kxRsgc',
    ),
  ],
  'Wednesday': [
    ExerciseData(
      name: 'Barbell Squat',
      sets: 4,
      reps: 10,
      tag: 'Legs',
      description: 'Compound lower body movement.',
      primaryMuscle: 'Quadriceps',
      secondaryMuscle: 'Glutes',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/dW3zj79xfrc?si=i2aGiM8eb7CKyg2I',
    ),
    ExerciseData(
      name: 'Romanian Deadlift',
      sets: 4,
      reps: 10,
      tag: 'Legs',
      description: 'Target hamstrings and glutes.',
      primaryMuscle: 'Hamstrings',
      secondaryMuscle: 'Glutes',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/5rIqP63yWFg?si=BfgZXWMiaefH6BwR',
    ),
    ExerciseData(
      name: 'Leg Press',
      sets: 4,
      reps: 12,
      tag: 'Legs',
      description: 'Heavy compound movement.',
      primaryMuscle: 'Quadriceps',
      secondaryMuscle: 'Glutes',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/EotSw18oR9w?si=00SOJTyrRSsqwSNa',
    ),
    ExerciseData(
      name: 'Leg Curl',
      sets: 4,
      reps: 12,
      tag: 'Legs',
      description: 'Hamstring isolation.',
      primaryMuscle: 'Hamstrings',
      secondaryMuscle: 'Calves',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/lGNeJsdqJwg?si=DVS3lactqUB2UxBv',
    ),
    ExerciseData(
      name: 'Standing Calf Raise',
      sets: 4,
      reps: 20,
      tag: 'Legs',
      description: 'Develop calf muscles.',
      primaryMuscle: 'Calves',
      secondaryMuscle: 'Ankles',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/wdOkFomQNp8?si=yit0YQGkStUR4rTk',
    ),
  ],
  'Thursday': [
    ExerciseData(
      name: 'Running',
      sets: 1,
      reps: 30,
      tag: 'Cardio',
      description: 'Steady pace running for 30 minutes.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Legs',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/bEY-ister9w?si=w63r9xKaU0Fm5sQq',
    ),
    ExerciseData(
      name: 'Jump Rope',
      sets: 4,
      reps: 90,
      tag: 'Cardio',
      description: '90 seconds continuous jumping.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Calves',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/Gt9hlRMXDXc?si=fNaXWLkV9R7NRgrX',
    ),
    ExerciseData(
      name: 'Burpees',
      sets: 4,
      reps: 15,
      tag: 'Cardio',
      description: 'High intensity full body exercise.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Chest',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/zDqi7OjlQdc?si=xcfKpT3dNrl7aezg',
    ),
    ExerciseData(
      name: 'Mountain Climbers',
      sets: 4,
      reps: 30,
      tag: 'Cardio',
      description: 'Increase endurance.',
      primaryMuscle: 'Core',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/fpmWW6iXfes?si=K3mGUTH4y4GEqtCl',
    ),
    ExerciseData(
      name: 'Cycling',
      sets: 1,
      reps: 30,
      tag: 'Cardio',
      description: '30-minute moderate cycling.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Legs',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/dieOsJlsvpM?si=SmvON2JOTmGmZwBS',
    ),
  ],
};

class Level2WorkoutScreen extends StatefulWidget {
  const Level2WorkoutScreen({super.key});

  @override
  State<Level2WorkoutScreen> createState() => _Level2WorkoutScreenState();
}

class _Level2WorkoutScreenState extends State<Level2WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    final todayWorkout = intermediateExercises[day] ?? [];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: AppBarTitleWidget(title: "WORKOUT"),
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
        padding: EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LEVEL 2: INTERMEDIATE',
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