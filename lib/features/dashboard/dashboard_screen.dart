import 'package:flutter/material.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/features/dashboard/progress_ring.dart';
import 'journey_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    const _RankCard(),
                    const SizedBox(height: 16),
                    const _StatRow(),
                    const SizedBox(height: 20),
                    _CtaButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _StreakPill(),
          const Text(
            'VOZ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 1.68,
              color: AppColors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, _, _) => const JourneyScreen(),
                  transitionsBuilder: (_, animation, _, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                          parent: animation, curve: Curves.easeOutCubic)),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: const _XpPill(),
          ),
        ],
      ),
    );
  }
}

class _StreakPill extends StatelessWidget {
  const _StreakPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.orange.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_fire_department,
              size: 14, color: AppColors.orange),
          const SizedBox(width: 4),
          const Text(
            '12',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _XpPill extends StatelessWidget {
  const _XpPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.pink.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.pink.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, size: 14, color: AppColors.pink),
          const SizedBox(width: 4),
          const Text(
            '2,450 XP',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: AppColors.pink,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankCard extends StatelessWidget {
  const _RankCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'CURRENT RANK',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            letterSpacing: 2.2,
            color: AppColors.pink,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'LEVEL 1: BEGINNER',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 12),
        const ProgressRing(percent: 45),
        const SizedBox(height: 12),
        Container(
          width: 118,
          height: 51,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(999),
            border:
                const Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Day 11',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.grayFill,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '/ 30',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _TodaysGoalCard()),
        SizedBox(width: 12),
        Expanded(child: _WeeklyStreakCard()),
      ],
    );
  }
}

class _TodaysGoalCard extends StatelessWidget {
  const _TodaysGoalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border:
            const Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TODAY'S GOAL",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              letterSpacing: 1.6,
              color: AppColors.pink,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Chest & Triceps',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              height: 1.2,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.fitness_center,
                  size: 12, color: AppColors.grayText),
              const SizedBox(width: 4),
              const Text(
                '6 exercises',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.grayText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeeklyStreakCard extends StatelessWidget {
  const _WeeklyStreakCard();

  @override
  Widget build(BuildContext context) {
    const completedDays = 6;
    const totalDays = 7;

    return Container(
      height: 152,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border:
            const Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WEEKLY STREAK',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              letterSpacing: 1.6,
              color: AppColors.pink,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(totalDays, (i) {
              final filled = i < completedDays;
              return Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? AppColors.pink : AppColors.grayDot,
                  boxShadow: filled
                      ? [
                          BoxShadow(
                            color: AppColors.pink.withValues(alpha: 0.55),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          const Text(
            '$completedDays / $totalDays',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pink,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.pink.withValues(alpha: 0.6),
                blurRadius: 24,
              ),
              BoxShadow(
                color: AppColors.pink.withValues(alpha: 0.25),
                blurRadius: 48,
              ),
            ],
          ),
          child: const Text(
            "START TODAY'S WORKOUT →",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 1.96,
              color: Color(0xFF111111),
            ),
          ),
        ),
      ),
    );
  }
}
