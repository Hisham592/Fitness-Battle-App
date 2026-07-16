import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/features/onboarding_auth/data/models/user_model.dart';
import 'package:voz_app/features/profile/controllers/profile_controller.dart';
import 'package:voz_app/features/profile/widgets/stat_badge_card.dart';

import 'avatar_store_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileController controller;

  const ProfileScreen({super.key, required this.controller});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final avatar = widget.controller.activeAvatar;

        return Scaffold(
          appBar: AppBar(
            title: AppBarTitleWidget(title: "PROFILE"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SettingsScreen(controller: widget.controller),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: Colors.grey.withValues(alpha: 0.3),
              ),
            ),
          ),
          body: SafeArea(
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser?.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryNeon,
                    ),
                  );
                }

                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    !snapshot.data!.exists) {
                  return const Center(
                    child: Text(
                      'Error fetching profile data',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                final firebaseUser = UserModel.fromMap(
                  snapshot.data!.data() as Map<String, dynamic>,
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accent.withValues(alpha: (0.12)),
                              border: Border.all(
                                color: AppColors.accent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accent.withValues(
                                    alpha: (0.55),
                                  ),
                                  blurRadius: 28,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Text(
                              avatar.emoji,
                              style: const TextStyle(fontSize: 56),
                            ),
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
                                  BoxShadow(
                                    color: AppColors.accent.withValues(
                                      alpha: (0.6),
                                    ),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.bolt,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        firebaseUser.name,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Level: ${firebaseUser.level} · Member since ${firebaseUser.createdAt.length >= 10 ? firebaseUser.createdAt.substring(0, 4) : ""}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 28),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 1.3,
                        children: [
                          const StatBadgeCard(
                            emoji: '🔥',
                            value: '12 Days',
                            label: 'Streak',
                          ),
                          StatBadgeCard(
                            emoji: '⚡',
                            value: '${firebaseUser.xp} XP',
                            label: 'Total XP',
                          ),
                          StatBadgeCard(
                            emoji: '💪',
                            value: '${firebaseUser.points} PTS',
                            label: 'Points',
                          ),
                          StatBadgeCard(
                            emoji: '🏆',
                            value: firebaseUser.level.toUpperCase(),
                            label: 'Level',
                          ),
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
                          leading: const Icon(
                            Icons.emoji_events_outlined,
                            color: AppColors.accent,
                          ),
                          title: const Text(
                            'MY JOURNEY & LEVELS',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: AppColors.textSecondary,
                          ),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AvatarStoreScreen(
                                controller: widget.controller,
                              ),
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
