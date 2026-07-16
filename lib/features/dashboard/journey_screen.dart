import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/features/onboarding_auth/data/models/user_model.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const AppBarTitleWidget(title: "MY JOURNEY"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            if (snapshot.hasError ||
                !snapshot.hasData ||
                !snapshot.data!.exists) {
              return const Center(
                child: Text(
                  'Error loading journey data',
                  style: TextStyle(color: AppColors.white),
                ),
              );
            }

            final firebaseUser = UserModel.fromMap(
              snapshot.data!.data() as Map<String, dynamic>,
            );
            final int userXP = firebaseUser.xp;

            final bool level1IsLocked = false;
            final String level1Status = userXP < 1500
                ? 'ACTIVE — Leveling up'
                : 'COMPLETED';
            final String level1XpValue = userXP < 1500
                ? '$userXP / 1500 XP'
                : '1500 / 1500 XP';
            final double level1Progress = userXP < 1500 ? (userXP / 1500) : 1.0;

            final bool level2IsLocked = userXP < 1500;
            final String level2Status = level2IsLocked
                ? 'Required XP'
                : (userXP < 5000 ? 'ACTIVE — Leveling up' : 'COMPLETED');
            final String? level2XpLabel = level2IsLocked ? null : 'XP Progress';
            final String level2XpValue = level2IsLocked
                ? '0 / 3500 XP'
                : (userXP < 5000
                      ? '${userXP - 1500} / 3500 XP'
                      : '3500 / 3500 XP');
            final double level2Progress = level2IsLocked
                ? 0.0
                : (userXP < 5000 ? ((userXP - 1500) / 3500) : 1.0);
            final String? level2LockNote = level2IsLocked
                ? 'Requires 1,500 total XP to unlock'
                : null;

            final bool level3IsLocked = userXP < 5000;
            final String level3Status = level3IsLocked
                ? 'Required XP'
                : 'ACTIVE — Ultimate Tier';
            final String? level3XpLabel = level3IsLocked ? null : 'XP Progress';
            final String level3XpValue = level3IsLocked
                ? 'Requires 5000 total XP'
                : '$userXP XP';
            final double level3Progress = level3IsLocked ? 0.0 : 1.0;
            final String? level3LockNote = level3IsLocked
                ? 'Requires 5,000 total XP to unlock'
                : null;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
              child: Column(
                children: [
                  _LevelTimelineItem(
                    index: '1',
                    isLocked: level1IsLocked,
                    isLast: false,
                    title: 'LEVEL 1 — BEGINNER',
                    statusText: level1Status,
                    xpLabel: 'XP Progress',
                    xpValue: level1XpValue,
                    progress: level1Progress,
                    lockNote: null,
                  ),
                  _LevelTimelineItem(
                    index: '2',
                    isLocked: level2IsLocked,
                    isLast: false,
                    title: 'LEVEL 2 — INTERMEDIATE',
                    statusText: level2Status,
                    xpLabel: level2XpLabel,
                    xpValue: level2XpValue,
                    progress: level2Progress,
                    lockNote: level2LockNote,
                  ),
                  _LevelTimelineItem(
                    index: '3',
                    isLocked: level3IsLocked,
                    isLast: true,
                    title: 'LEVEL 3 — ADVANCED',
                    statusText: level3Status,
                    xpLabel: level3XpLabel,
                    xpValue: level3XpValue,
                    progress: level3Progress,
                    lockNote: level3LockNote,
                  ),
                ],
              ),
            );
          },
        ),
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
    final primaryColor = Theme.of(context).colorScheme.primary;

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
                          : LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [primaryColor, AppColors.grayDot],
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
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isLocked ? AppColors.lockedNode : primaryColor,
        boxShadow: isLocked
            ? null
            : [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.6),
                  blurRadius: 24,
                ),
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.25),
                  blurRadius: 48,
                ),
              ],
      ),
      child: isLocked
          ? const Icon(
              Icons.lock_outline,
              size: 18,
              color: AppColors.lockedIcon,
            )
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
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLocked
            ? const Color(0xFF161616)
            : primaryColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          top: BorderSide(
            color: isLocked
                ? AppColors.border
                : primaryColor.withValues(alpha: 0.38),
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
              color: isLocked ? const Color(0xFF555555) : primaryColor,
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
                  style: const TextStyle(fontSize: 12, color: AppColors.green),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          if (isLocked && statusText != null) ...[
            Text(
              statusText!,
              style: const TextStyle(fontSize: 12, color: Color(0xFF555555)),
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
                      style: const TextStyle(
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
                            : primaryColor,
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
                      color: isLocked
                          ? const Color(0xFF3A3A3A)
                          : primaryColor,
                      boxShadow: isLocked
                          ? null
                          : [
                              BoxShadow(
                                color: primaryColor,
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
                const Icon(
                  Icons.lock_outline,
                  size: 11,
                  color: Color(0xFF555555),
                ),
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
