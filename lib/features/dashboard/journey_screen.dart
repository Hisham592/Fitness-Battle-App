import 'package:flutter/material.dart';
import 'package:voz_app/core/theme/app_colors.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _JourneyTopBar(),
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 28, 20, 20),
                child: Column(
                  children: [
                    _LevelTimelineItem(
                      index: '1',
                      isLocked: false,
                      isLast: false,
                      title: 'LEVEL 1 — BEGINNER',
                      statusText: 'ACTIVE — Current Day: 11',
                      xpLabel: 'XP Progress',
                      xpValue: '320 / 500 XP',
                      progress: 0.64,
                      lockNote: null,
                    ),
                    _LevelTimelineItem(
                      index: '2',
                      isLocked: true,
                      isLast: false,
                      title: 'LEVEL 2 — INTERMEDIATE',
                      statusText: 'Required XP',
                      xpLabel: null,
                      xpValue: '320 / 500',
                      progress: 0.64,
                      lockNote: 'Requires 500 XP to unlock',
                    ),
                    _LevelTimelineItem(
                      index: '3',
                      isLocked: true,
                      isLast: true,
                      title: 'LEVEL 3 — ADVANCED',
                      statusText: null,
                      xpLabel: null,
                      xpValue: null,
                      progress: null,
                      lockNote: 'Requires 1,200 XP to unlock',
                    ),
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

class _JourneyTopBar extends StatelessWidget {
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
        children: [
          SizedBox(
            width: 28,
            height: 32,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 18, color: AppColors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'MY JOURNEY',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 2.08,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelTimelineItem extends StatelessWidget {
  final String index;
  final bool isLocked;
  final bool isLast;
  final String title;
  final String? statusText;
  final String? xpLabel;
  final String? xpValue;
  final double? progress;
  final String? lockNote;

  const _LevelTimelineItem({
    required this.index,
    required this.isLocked,
    required this.isLast,
    required this.title,
    required this.statusText,
    required this.xpLabel,
    required this.xpValue,
    required this.progress,
    required this.lockNote,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _Node(index: index, isLocked: isLocked),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      gradient: isLocked
                          ? null
                          : const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.pink,
                                AppColors.grayDot,
                              ],
                            ),
                      color: isLocked ? AppColors.grayDot : null,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _LevelCard(
                isLocked: isLocked,
                title: title,
                statusText: statusText,
                xpLabel: xpLabel,
                xpValue: xpValue,
                progress: progress,
                lockNote: lockNote,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Node extends StatelessWidget {
  final String index;
  final bool isLocked;

  const _Node({required this.index, required this.isLocked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isLocked ? AppColors.lockedNode : AppColors.pink,
        boxShadow: isLocked
            ? null
            : [
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
      child: isLocked
          ? const Icon(Icons.lock_outline,
              size: 18, color: AppColors.lockedIcon)
          : Text(
              index,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xFF111111),
              ),
            ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final bool isLocked;
  final String title;
  final String? statusText;
  final String? xpLabel;
  final String? xpValue;
  final double? progress;
  final String? lockNote;

  const _LevelCard({
    required this.isLocked,
    required this.title,
    required this.statusText,
    required this.xpLabel,
    required this.xpValue,
    required this.progress,
    required this.lockNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLocked
            ? const Color(0xFF161616)
            : AppColors.pink.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          top: BorderSide(
            color: isLocked
                ? AppColors.border
                : AppColors.pink.withValues(alpha: 0.38),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: isLocked ? const Color(0xFF555555) : AppColors.pink,
            ),
          ),
          const SizedBox(height: 8),
          if (!isLocked && statusText != null) ...[
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  statusText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          if (isLocked && statusText != null) ...[
            Text(
              statusText!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF555555),
              ),
            ),
            const SizedBox(height: 6),
          ],
          if (xpLabel != null || xpValue != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (xpLabel != null)
                     Text(
                      xpLabel!,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.grayLabel,
                      ),
                    ),
                  if (xpValue != null)
                    Text(
                      xpValue!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: isLocked
                            ? const Color(0xFF555555)
                            : AppColors.pink,
                      ),
                    ),
                ],
              ),
            ),
          if (progress != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                height: 5,
                color: const Color(0xFF1E1E1E),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress!.clamp(0, 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isLocked ? const Color(0xFF3A3A3A) : AppColors.pink,
                      boxShadow: isLocked
                          ? null
                          : [
                              const BoxShadow(
                                color: AppColors.pink,
                                blurRadius: 6,
                              ),
                            ],
                    ),
                  ),
                ),
              ),
            ),
          if (lockNote != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.lock_outline,
                    size: 11, color: Color(0xFF555555)),
                const SizedBox(width: 6),
                Text(
                  lockNote!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}