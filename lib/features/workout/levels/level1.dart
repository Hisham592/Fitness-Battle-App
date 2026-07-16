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
final Map<String, List<ExerciseData>> beginnerExercises = {
  'Saturday': [
    ExerciseData(
      name: 'Push-ups',
      sets: 3,
      reps: 10,
      tag: 'Chest',
      description: 'Classic bodyweight exercise for chest strength.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtu.be/wxhNoKZlfY8?si=cgcpKf8sE2m0RpaX',
    ),
    ExerciseData(
      name: 'Incline Push-ups',
      sets: 3,
      reps: 12,
      tag: 'Chest',
      description: 'Push-ups using a bench to reduce difficulty.',
      primaryMuscle: 'Upper Chest',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/SOu-3_YyX2c?si=dHy3gLqaLhf-ANOE',
    ),
    ExerciseData(
      name: 'Dumbbell Bench Press',
      sets: 3,
      reps: 10,
      tag: 'Chest',
      description: 'Press dumbbells while lying on a bench.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/mTaiQemkEpU?si=fCRsCLqmdnsjfKhJ',
    ),
    ExerciseData(
      name: 'Chest Fly',
      sets: 3,
      reps: 12,
      tag: 'Chest',
      description: 'Stretch and squeeze the chest muscles.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Front Shoulders',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/rk8YayRoTRQ?si=tuz2cTW0dki9gezO',
    ),
    ExerciseData(
      name: 'Machine Chest Press',
      sets: 3,
      reps: 12,
      tag: 'Chest',
      description: 'Controlled chest press using a machine.',
      primaryMuscle: 'Chest',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/chest.png',
      videoUrl: 'https://youtube.com/shorts/Qu7-ceCvq7w?si=ZZXfEHrA_ooojT36',
    ),
  ],
  'Sunday': [
    ExerciseData(
      name: 'Lat Pulldown',
      sets: 3,
      reps: 12,
      tag: 'Back',
      description: 'Pull the bar toward your upper chest.',
      primaryMuscle: 'Lats',
      secondaryMuscle: 'Biceps',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/bNmvKpJSWKM?si=kXx7SYnndzvoxYpf',
    ),
    ExerciseData(
      name: 'Seated Cable Row',
      sets: 3,
      reps: 12,
      tag: 'Back',
      description: 'Pull the cable toward your waist.',
      primaryMuscle: 'Middle Back',
      secondaryMuscle: 'Biceps',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtu.be/GZbfZ033f74?si=Xtljwmcf7DdlMp_m',
    ),
    ExerciseData(
      name: 'One Arm Dumbbell Row',
      sets: 3,
      reps: 10,
      tag: 'Back',
      description: 'Row one dumbbell at a time.',
      primaryMuscle: 'Lats',
      secondaryMuscle: 'Rear Delts',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/WkFX6_GxAs8?si=l3E2BaoU4MebdREA',
    ),
    ExerciseData(
      name: 'Straight Arm Pulldown',
      sets: 3,
      reps: 12,
      tag: 'Back',
      description: 'Isolation exercise for the lats.',
      primaryMuscle: 'Lats',
      secondaryMuscle: 'Core',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/1_E77qhMpkE?si=nuTrB5E83_B-F1Xc',
    ),
    ExerciseData(
      name: 'Machine Row',
      sets: 3,
      reps: 12,
      tag: 'Back',
      description: 'Beginner-friendly rowing exercise.',
      primaryMuscle: 'Back',
      secondaryMuscle: 'Biceps',
      iconPath: 'assets/icons/exercises/back.png',
      videoUrl: 'https://youtube.com/shorts/E7ngsffMPR0?si=VuSdgQwQgZTCZfI0',
    ),
  ],
  'Monday': [
    ExerciseData(
      name: 'Seated Dumbbell Press',
      sets: 3,
      reps: 10,
      tag: 'Shoulders',
      description: 'Press dumbbells overhead.',
      primaryMuscle: 'Front Delts',
      secondaryMuscle: 'Triceps',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/k6tzKisR3NY?si=NBhuJwtVgmR0Qbvd',
    ),
    ExerciseData(
      name: 'Lateral Raise',
      sets: 3,
      reps: 12,
      tag: 'Shoulders',
      description: 'Raise dumbbells to shoulder level.',
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
      description: 'Lift dumbbells in front of your body.',
      primaryMuscle: 'Front Delts',
      secondaryMuscle: 'Upper Chest',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/h9xfpTrAvkE?si=h9wW949eiouFGnRI',
    ),
    ExerciseData(
      name: 'Reverse Pec Deck',
      sets: 3,
      reps: 12,
      tag: 'Shoulders',
      description: 'Targets rear shoulder muscles.',
      primaryMuscle: 'Rear Delts',
      secondaryMuscle: 'Upper Back',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/7tgx6QHB0-A?si=jgvt82zWd5zyriSD',
    ),
    ExerciseData(
      name: 'Dumbbell Shrugs',
      sets: 3,
      reps: 15,
      tag: 'Shoulders',
      description: 'Lift shoulders toward your ears.',
      primaryMuscle: 'Traps',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/sholders.png',
      videoUrl: 'https://youtube.com/shorts/rFsSeClGnNA?si=LCoLJm5pUD-ZCfdG',
    ),
  ],
  'Tuesday': [],
  'Wednesday': [
    ExerciseData(
      name: 'Dumbbell Curl',
      sets: 3,
      reps: 12,
      tag: 'Arms',
      description: 'Basic dumbbell curl for building biceps.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/MKWBV29S6c0?si=7QgnybHdoM-KaY57',
    ),
    ExerciseData(
      name: 'Hammer Curl',
      sets: 3,
      reps: 12,
      tag: 'Arms',
      description: 'Neutral grip curl targeting the brachialis.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtu.be/BRVDS6HVR9Q?si=nIeeFHI6E2w03gHl',
    ),
    ExerciseData(
      name: 'Cable Curl',
      sets: 3,
      reps: 12,
      tag: 'Arms',
      description: 'Cable curl with constant tension throughout the movement.',
      primaryMuscle: 'Biceps',
      secondaryMuscle: 'Forearms',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/CrbTqNOlFgE?si=cCAjBAgJ0NT3zCI0',
    ),
    ExerciseData(
      name: 'Triceps Pushdown',
      sets: 3,
      reps: 12,
      tag: 'Arms',
      description: 'Push the cable down until your arms are fully extended.',
      primaryMuscle: 'Triceps',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/1FjkhpZsaxc?si=6vdf90AR0J6VC4Ul',
    ),
    ExerciseData(
      name: 'Overhead Dumbbell Extension',
      sets: 3,
      reps: 12,
      tag: 'Arms',
      description: 'Perform an overhead extension with a dumbbell.',
      primaryMuscle: 'Triceps',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/bi&tri.png',
      videoUrl: 'https://youtube.com/shorts/b_r_LW4HEcM?si=q_C2aP0La3gGI8b3',
    ),
  ],
  'Thursday': [
    ExerciseData(
      name: 'Bodyweight Squat',
      sets: 3,
      reps: 15,
      tag: 'Legs',
      description: 'Basic squat using only your body weight.',
      primaryMuscle: 'Quadriceps',
      secondaryMuscle: 'Glutes',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/n_xLyzPEX7A?si=t5kV8JKnH-MdfohM',
    ),
    ExerciseData(
      name: 'Leg Press',
      sets: 3,
      reps: 12,
      tag: 'Legs',
      description: 'Push the platform away using both legs.',
      primaryMuscle: 'Quadriceps',
      secondaryMuscle: 'Glutes',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/EotSw18oR9w?si=00SOJTyrRSsqwSNa',
    ),
    ExerciseData(
      name: 'Leg Extension',
      sets: 3,
      reps: 12,
      tag: 'Legs',
      description: 'Isolate and strengthen the quadriceps.',
      primaryMuscle: 'Quadriceps',
      secondaryMuscle: 'None',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtu.be/YyvSfVjQeL0?si=HB4igC4IbqNn6EJ8',
    ),
    ExerciseData(
      name: 'Leg Curl',
      sets: 3,
      reps: 12,
      tag: 'Legs',
      description: 'Strengthen the hamstrings using a leg curl machine.',
      primaryMuscle: 'Hamstrings',
      secondaryMuscle: 'Calves',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/lGNeJsdqJwg?si=DVS3lactqUB2UxBv',
    ),
    ExerciseData(
      name: 'Standing Calf Raise',
      sets: 3,
      reps: 15,
      tag: 'Legs',
      description: 'Raise your heels to strengthen the calf muscles.',
      primaryMuscle: 'Calves',
      secondaryMuscle: 'Ankles',
      iconPath: 'assets/icons/exercises/leg.png',
      videoUrl: 'https://youtube.com/shorts/wdOkFomQNp8?si=nh5pSV67s3MxQrNU',
    ),
  ],
  'Friday': [
    ExerciseData(
      name: 'Brisk Walking',
      sets: 1,
      reps: 20,
      tag: 'Cardio',
      description: 'Walk briskly for 20 minutes.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Legs',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtu.be/nmvVfgrExAg?si=uFLQEr4yp30QwNL-',
    ),
    ExerciseData(
      name: 'Jump Rope',
      sets: 3,
      reps: 60,
      tag: 'Cardio',
      description: 'Jump rope continuously for 60 seconds.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Calves',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/Gt9hlRMXDXc?si=fNaXWLkV9R7NRgrX',
    ),
    ExerciseData(
      name: 'Mountain Climbers',
      sets: 3,
      reps: 20,
      tag: 'Cardio',
      description: 'Alternate driving your knees toward your chest.',
      primaryMuscle: 'Core',
      secondaryMuscle: 'Shoulders',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/fpmWW6iXfes?si=K3mGUTH4y4GEqtCl',
    ),
    ExerciseData(
      name: 'High Knees',
      sets: 3,
      reps: 30,
      tag: 'Cardio',
      description: 'Run in place while lifting your knees as high as possible.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Legs',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/LJMrXG_vPQ8?si=r473dKBO7AdawqQv',
    ),
    ExerciseData(
      name: 'Cycling',
      sets: 1,
      reps: 20,
      tag: 'Cardio',
      description: 'Cycle at a moderate pace for 20 minutes.',
      primaryMuscle: 'Cardiovascular',
      secondaryMuscle: 'Legs',
      iconPath: 'assets/icons/exercises/cardio.png',
      videoUrl: 'https://youtube.com/shorts/dieOsJlsvpM?si=SmvON2JOTmGmZwBS',
    ),
  ],
};

class Level1WorkoutScreen extends StatefulWidget {
  const Level1WorkoutScreen({super.key});

  @override
  State<Level1WorkoutScreen> createState() => _Level1WorkoutScreenState();
}

class _Level1WorkoutScreenState extends State<Level1WorkoutScreen> {
  final Set<int> _completedIndices = {};

  @override
  Widget build(BuildContext context) {
    final todayWorkout = beginnerExercises[day] ?? [];
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
                  'LEVEL 1: BEGINNER',
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
                              if (context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AchiveScreen(
                                      xpEarned: result['xpEarned'] ?? 50,
                                      streakDays: result['streak'] ?? 1,
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
