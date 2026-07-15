import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/stat_badge_card.dart';
import 'avatar_store_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileController controller;

  const ProfileScreen({super.key, required this.controller});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _navIndex = 3; // Profile tab active

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final profile = widget.controller.profile;
        final avatar = widget.controller.activeAvatar;

        return Scaffold(
          appBar: AppBar(
            title: const Text('PROFILE'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(controller: widget.controller),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // Circular avatar badge with neon glow + lightning indicator.
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent.withOpacity(0.12),
                          border: Border.all(color: AppColors.accent, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.55),
                              blurRadius: 28,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Text(avatar.emoji, style: const TextStyle(fontSize: 56)),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.accent,
                            boxShadow: [
                              BoxShadow(color: AppColors.accent.withOpacity(0.6), blurRadius: 10),
                            ],
                          ),
                          child: const Icon(Icons.bolt, color: Colors.black, size: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    profile.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${profile.levelLabel} · Member since ${profile.memberSinceYear}',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 28),

                  // Badge cards: Active Days, Total Points, Workouts, Level.
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.3,
                    children: [
                      StatBadgeCard(emoji: '🔥', value: '${profile.streakDays} Days', label: 'Streak'),
                      StatBadgeCard(emoji: '⚡', value: '${profile.totalPoints} PTS', label: 'Total XP'),
                      StatBadgeCard(emoji: '💪', value: '${profile.workoutsDone} Done', label: 'Workouts'),
                      StatBadgeCard(emoji: '🏅', value: profile.levelTier, label: 'Level'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.surfaceBorder),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.emoji_events_outlined, color: AppColors.accent),
                      title: const Text(
                        'MY JOURNEY & LEVELS',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AvatarStoreScreen(controller: widget.controller),
                        ),
                      ),
                      child: const Text(
                        'ENTER AVATAR STORE →',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: _navIndex,
            onTap: (i) => setState(() => _navIndex = i),
          ),
        );
      },
    );
  }
}
