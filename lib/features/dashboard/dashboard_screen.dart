import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/main_layout_screen.dart';
import 'package:voz_app/features/dashboard/progress_ring.dart';
import 'package:voz_app/features/workout/levels/level1.dart';
import 'journey_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            'Not signed in',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: Text(
                'No user data found',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final String level = data['level'] ?? 'Beginner';
        final int xp = data['xp'] ?? 0;
        final int streak = data['streak'] ?? 0;
        final int daysCount = data['daysCount'] ?? 1;
        final List<String> completedDays =
            (data['completedDays'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [];

        final int xpPercent = _computeXpPercent(level, xp);

        final String today = DateFormat('EEEE').format(DateTime.now());
        final List<dynamic> todayExercises = beginnerExercises[today] ?? [];
        final bool isRestDay = todayExercises.isEmpty;

        final String todaysGoalText = isRestDay
            ? 'Rest Day'
            : _buildTodaysGoalText(todayExercises);

        final int exerciseCount = todayExercises.length;

        final String todayDateStr =
            DateFormat('yyyy-MM-dd').format(DateTime.now());
        final bool isCompletedToday = completedDays.contains(todayDateStr);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const AppBarTitleWidget(title: "VOZ"),
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Center(child: _StreakPill(streak: streak)),
            ),
            leadingWidth: 80.w,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (_, _, _) => const JourneyScreen(),
                        transitionsBuilder: (_, animation, _, child) {
                          return SlideTransition(
                            position:
                                Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: _XpPill(xp: xp),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.h),
              child: Container(
                height: 1.h,
                color: Colors.grey.withValues(alpha: 0.3),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                _RankCard(
                  level: level,
                  xpPercent: xpPercent,
                  daysCount: daysCount,
                ),
                SizedBox(height: 16.h),
                _TodaysGoalCard(
                  goalText: todaysGoalText,
                  exerciseCount: exerciseCount,
                  isRestDay: isRestDay,
                ),
                SizedBox(height: 16.h),
                _WeeklyCalendarGrid(completedDays: completedDays),
                SizedBox(height: 20.h),
                _CtaButton(
                  isRestDay: isRestDay,
                  isCompleted: isCompletedToday,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  static int _computeXpPercent(String level, int xp) {
    final normalized = level.toLowerCase();
    double percent;

    if (normalized == 'beginner') {
      percent = (xp / 1500) * 100;
    } else if (normalized == 'intermediate') {
      percent = ((xp - 1500) / 3500) * 100;
    } else {
      percent = 100;
    }

    return percent.clamp(0, 100).toInt();
  }

  static String _buildTodaysGoalText(List<dynamic> exercises) {
    final primary = exercises.first.primaryMuscle as String;
    final secondary = exercises.first.secondaryMuscle as String;
    return '$primary & $secondary';
  }
}

class _StreakPill extends StatelessWidget {
  final int streak;

  const _StreakPill({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.orange.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            size: 14.sp,
            color: AppColors.orange,
          ),
          SizedBox(width: 4.w),
          Text(
            '$streak',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _XpPill extends StatelessWidget {
  final int xp;

  const _XpPill({required this.xp});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: primaryColor.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/icons/outlineVoltIcon.svg",
            width: 9.w,
            height: 10.h,
            colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
          ),
          SizedBox(width: 4.w),
          Text(
            '$xp XP',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankCard extends StatelessWidget {
  final String level;
  final int xpPercent;
  final int daysCount;

  const _RankCard({
    required this.level,
    required this.xpPercent,
    required this.daysCount,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Text(
          'CURRENT RANK',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            letterSpacing: 2.2,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Level : $level',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 12.h),
        ProgressRing(percent: xpPercent.toDouble()),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(999.r),
            border: Border(
              top: BorderSide(color: AppColors.border, width: 1.w),
            ),
          ),
          child: Text(
            'Day $daysCount',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _TodaysGoalCard extends StatelessWidget {
  final String goalText;
  final int exerciseCount;
  final bool isRestDay;

  const _TodaysGoalCard({
    required this.goalText,
    required this.exerciseCount,
    required this.isRestDay,
  });

  String _getMuscleAssetPath(String text, bool isRest) {
    if (isRest) return 'assets/icons/exercises/cardio.png';
    final lower = text.toLowerCase();
    if (lower.contains('cardio') || lower.contains('cardiovascular')) {
      return 'assets/icons/exercises/cardio.png';
    }
    if (lower.contains('chest')) return 'assets/icons/exercises/chest.png';
    if (lower.contains('back') || lower.contains('lat')) {
      return 'assets/icons/exercises/back.png';
    }
    if (lower.contains('shoulder') ||
        lower.contains('delt') ||
        lower.contains('trap')) {
      return 'assets/icons/exercises/sholders.png';
    }
    if (lower.contains('arm') ||
        lower.contains('biceps') ||
        lower.contains('triceps')) {
      return 'assets/icons/exercises/bi&tri.png';
    }
    if (lower.contains('leg') ||
        lower.contains('quad') ||
        lower.contains('hamstring') ||
        lower.contains('calf')) {
      return 'assets/icons/exercises/leg.png';
    }
    return 'assets/icons/exercises/cardio.png';
  }

  @override
  Widget build(BuildContext context) {
    final assetPath = _getMuscleAssetPath(goalText, isRestDay);

    return Container(
      width: double.infinity,
      height: 115.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TODAY'S GOAL",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    letterSpacing: 1.6,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  goalText,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    height: 1.2,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      isRestDay
                          ? Icons.self_improvement
                          : Icons.fitness_center,
                      size: 18.sp,
                      color: AppColors.grayText,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      isRestDay ? 'Enjoy your rest' : '$exerciseCount exercises',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.grayText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          SizedBox(
            width: 76.w,
            height: 76.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyCalendarGrid extends StatelessWidget {
  final List<String> completedDays;

  const _WeeklyCalendarGrid({required this.completedDays});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final int daysSinceSaturday = (now.weekday - DateTime.saturday + 7) % 7;
    final DateTime saturdayDate = now.subtract(
      Duration(days: daysSinceSaturday),
    );

    final List<Map<String, String>> daysConfig = [
      {'code': 'SAT', 'dayName': 'Saturday'},
      {'code': 'SUN', 'dayName': 'Sunday'},
      {'code': 'MON', 'dayName': 'Monday'},
      {'code': 'TUE', 'dayName': 'Tuesday'},
      {'code': 'WED', 'dayName': 'Wednesday'},
      {'code': 'THU', 'dayName': 'Thursday'},
      {'code': 'FRI', 'dayName': 'Friday'},
    ];

    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          final config = daysConfig[index];
          final dayName = config['dayName']!;
          final code = config['code']!;

          final columnDate = saturdayDate.add(Duration(days: index));
          final dateStr = DateFormat('yyyy-MM-dd').format(columnDate);

          final exercises = beginnerExercises[dayName] ?? [];
          final bool isRestDay = exercises.isEmpty;

          final bool isCompleted =
              completedDays.contains(dateStr) ||
              completedDays.contains(dayName);
          final bool isLitUp = isCompleted || isRestDay;

          final String muscleLabel = isRestDay
              ? 'Rest'
              : (exercises.isNotEmpty ? exercises.first.tag : 'Workout');

          final Color circleColor = !isLitUp
              ? AppColors.grayDot
              : (isRestDay ? AppColors.orange : primaryColor);

          final List<BoxShadow>? circleShadow = !isLitUp
              ? null
              : [
                  BoxShadow(
                    color: (isRestDay ? AppColors.orange : primaryColor)
                        .withValues(alpha: 0.6),
                    blurRadius: 8.r,
                  ),
                ];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                code,
                style: TextStyle(
                  color: AppColors.grayText,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleColor,
                  boxShadow: circleShadow,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                muscleLabel,
                style: TextStyle(
                  color: isLitUp ? AppColors.white : AppColors.grayText,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final bool isRestDay;
  final bool isCompleted;

  const _CtaButton({
    required this.isRestDay,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = isRestDay || isCompleted;
    final primaryColor = Theme.of(context).colorScheme.primary;

    final String buttonText = isCompleted
        ? "WORKOUT COMPLETED"
        : (isRestDay ? "TODAY IS A REST DAY" : "START TODAY'S WORKOUT →");

    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: isDisabled
            ? null
            : () {
                MainLayoutController.of(context)?.switchTab(1);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? AppColors.grayFill.withValues(alpha: 0.4)
              : primaryColor,
          disabledBackgroundColor: AppColors.grayFill.withValues(alpha: 0.4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: isDisabled
                ? []
                : [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.6),
                      blurRadius: 24.r,
                    ),
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.25),
                      blurRadius: 48.r,
                    ),
                  ],
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              letterSpacing: 1.96,
              color: isDisabled ? AppColors.grayText : const Color(0xFF111111),
            ),
          ),
        ),
      ),
    );
  }
}
