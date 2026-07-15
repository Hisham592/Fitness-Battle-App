import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/progress_ring.dart';
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
            const _BottomNav(),
          ],
        ),
      ),
    );
  }
}

// ================= TOP BAR =================
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
          Text(
            'VOZ',
            style: GoogleFonts.rajdhani(
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
                  pageBuilder: (_, __, ___) => const JourneyScreen(),
                  transitionsBuilder: (_, animation, __, child) {
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
        color: AppColors.orange.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.orange.withOpacity(0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_fire_department,
              size: 14, color: AppColors.orange),
          const SizedBox(width: 4),
          Text(
            '12',
            style: GoogleFonts.rajdhani(
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
        color: AppColors.pink.withOpacity(0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.pink.withOpacity(0.45)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, size: 14, color: AppColors.pink),
          const SizedBox(width: 4),
          Text(
            '2,450 XP',
            style: GoogleFonts.rajdhani(
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

// ================= RANK CARD =================
class _RankCard extends StatelessWidget {
  const _RankCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'CURRENT RANK',
          style: GoogleFonts.rajdhani(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            letterSpacing: 2.2,
            color: AppColors.pink,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'LEVEL 1: BEGINNER',
          style: GoogleFonts.rajdhani(
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
              Text(
                'Day 11',
                style: GoogleFonts.rajdhani(
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
                child: Text(
                  '/ 30',
                  style: GoogleFonts.barlow(
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

// ================= STAT ROW (Today's Goal / Weekly Streak) =================
class _StatRow extends StatelessWidget {
  const _StatRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _TodaysGoalCard()),
        const SizedBox(width: 12),
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
          Text(
            "TODAY'S GOAL",
            style: GoogleFonts.rajdhani(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              letterSpacing: 1.6,
              color: AppColors.pink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Chest & Triceps',
            style: GoogleFonts.rajdhani(
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
              Text(
                '6 exercises',
                style: GoogleFonts.barlow(
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
    // 6 of 7 days completed, matching the design.
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
          Text(
            'WEEKLY STREAK',
            style: GoogleFonts.rajdhani(
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
                            color: AppColors.pink.withOpacity(0.55),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedDays / $totalDays',
            style: GoogleFonts.rajdhani(
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

// ================= CTA BUTTON =================
class _CtaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          // TODO: hook up to the workout flow
        },
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
                color: AppColors.pink.withOpacity(0.6),
                blurRadius: 24,
              ),
              BoxShadow(
                color: AppColors.pink.withOpacity(0.25),
                blurRadius: 48,
              ),
            ],
          ),
          child: Text(
            "START TODAY'S WORKOUT →",
            style: GoogleFonts.rajdhani(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 1.96,
              color: const Color(0xFF111111),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= BOTTOM NAV =================
class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavItem(icon: Icons.home_rounded, label: 'Home', active: true),
          _NavItem(icon: Icons.fitness_center, label: 'Workout'),
          _NavItem(icon: Icons.restaurant_menu, label: 'Nutrition'),
          _NavItem(icon: Icons.person_outline, label: 'Profile'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({required this.icon, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.pink : Colors.grey[600];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.barlow(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: color,
          ),
        ),
      ],
    );
  }
}
