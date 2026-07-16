import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/main_layout_screen.dart';

class AchiveScreen extends StatelessWidget {
  const AchiveScreen({
    super.key,
    this.xpEarned = 0,
    this.streakDays = 0,
    this.onReturn,
  });

  final int xpEarned;
  final int streakDays;
  final VoidCallback? onReturn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: _ConfettiField(dotCount: 50)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: _CompleteCard(
                  xpEarned: xpEarned,
                  streakDays: streakDays,
                  onReturn:
                      onReturn ??
                      () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MainLayoutScreen(),
                        ),
                        (route) => false,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompleteCard extends StatelessWidget {
  const _CompleteCard({
    required this.xpEarned,
    required this.streakDays,
    required this.onReturn,
  });

  final int xpEarned;
  final int streakDays;
  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primaryColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.45),
            blurRadius: 18,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _GlowingCheck(color: primaryColor),
          const SizedBox(height: 20),
          Text(
            'CHALLENGE COMPLETE',
            style: TextStyle(
              color: primaryColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.42,
              fontFamily: 'Rajdhani',
            ),
          ),
          const SizedBox(height: 7),
          Text(
            '+$xpEarned XP COLLECTED!\nSTREAK MAINTAINED!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 27.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Rajdhani',
            ),
          ),
          Text(
            "You're on day $streakDays. Keep the momentum going —\ntomorrow awaits.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'barlow',
            ),
          ),
          const SizedBox(height: 20),
          _StreakPill(streakDays: streakDays),
          const SizedBox(height: 22),
          _ReturnButton(
            onPressed: onReturn,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}

class _GlowingCheck extends StatelessWidget {
  const _GlowingCheck({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.w,
      height: 76.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.timerback.withValues(alpha: 0.12),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.60),
            blurRadius: 48,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/done.svg',
          width: 22.w,
          height: 15.h,
        ),
      ),
    );
  }
}

class _StreakPill extends StatelessWidget {
  const _StreakPill({required this.streakDays});
  final int streakDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF37241E),
        borderRadius: BorderRadius.circular(33),
        border: Border.all(color: const Color(0XFF673523), width: 1.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.w,
        children: [
          SvgPicture.asset(
            'assets/icons/heat icon.svg',
            width: 7.w,
            height: 10.h,
          ),
          Text(
            '$streakDays-DAY STREAK 🔥',
            style: const TextStyle(
              color: Color(0xFFFF6C36),
              fontSize: 13,
              fontFamily: 'Rajdhani',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReturnButton extends StatelessWidget {
  const _ReturnButton({required this.onPressed, required this.color});
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.6),
            blurRadius: 24,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onPressed,
          child: const Center(
            child: Text(
              'RETURN TO DASHBOARD ',
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfettiField extends StatelessWidget {
  const _ConfettiField({required this.dotCount});
  final int dotCount;

  static const _palette = [
    Color(0xFFE026F5),
    Color(0xFFFF8A3D),
    Color(0xFF5CD6C0),
    Color(0xFF6C6CF5),
    Color(0xFFFFFFFF),
  ];

  @override
  Widget build(BuildContext context) {
    final rnd = Random(7);
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final topZoneHeight = constraints.maxHeight * 0.32;
        return Stack(
          children: List.generate(dotCount, (i) {
            final size = 4.0 + rnd.nextDouble() * 5;
            return Positioned(
              left: rnd.nextDouble() * w,
              top: rnd.nextDouble() * topZoneHeight,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: _palette[rnd.nextInt(_palette.length)],
                  borderRadius: BorderRadius.circular(size / 2),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
