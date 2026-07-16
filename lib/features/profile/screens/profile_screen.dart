import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/core/widgets/custom_neon_button.dart';
import 'package:voz_app/features/dashboard/journey_screen.dart';
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
    final primaryColor = Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const AppBarTitleWidget(title: "PROFILE"),
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
              preferredSize: Size.fromHeight(1.h),
              child: Container(
                height: 1.h,
                color: Colors.grey.withValues(alpha: 0.3),
              ),
            ),
          ),
          body: SafeArea(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    !snapshot.data!.exists) {
                  return Center(
                    child: Text(
                      'Error fetching profile data',
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  );
                }

                final firebaseUser = UserModel.fromMap(
                  snapshot.data!.data() as Map<String, dynamic>,
                );

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 140.w,
                            height: 140.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withValues(alpha: 0.12),
                              border: Border.all(
                                color: primaryColor,
                                width: 2.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(
                                    alpha: 0.55,
                                  ),
                                  blurRadius: 28.r,
                                  spreadRadius: 2.r,
                                ),
                              ],
                            ),
                            child: Text(
                              firebaseUser.activeAvatar,
                              style: TextStyle(fontSize: 56.sp),
                            ),
                          ),
                          Positioned(
                            bottom: 4.h,
                            right: 4.w,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withValues(
                                      alpha: 0.6,
                                    ),
                                    blurRadius: 10.r,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.bolt,
                                color: Colors.black,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        firebaseUser.name,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Member since ${firebaseUser.createdAt.length >= 10 ? firebaseUser.createdAt.substring(0, 4) : ""}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(height: 28.h),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 14.h,
                        crossAxisSpacing: 14.w,
                        childAspectRatio: 1.3,
                        children: [
                          StatBadgeCard(
                            emoji: '🔥',
                            value: '${firebaseUser.streak} days',
                            label: 'Streak',
                          ),
                          StatBadgeCard(
                            emoji: '⚡',
                            value: '${firebaseUser.xp} XP',
                            label: 'Total XP',
                          ),
                          StatBadgeCard(
                            emoji: '🎫',
                            value: '${firebaseUser.points} PTS',
                            label: 'Points',
                          ),
                          StatBadgeCard(
                            emoji: '🎖️',
                            value: firebaseUser.level.toUpperCase(),
                            label: 'Level',
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.surfaceBorder),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.emoji_events_outlined,
                            color: primaryColor,
                          ),
                          title: Text(
                            'MY JOURNEY & LEVELS',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.sp,
                              letterSpacing: 0.5,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: AppColors.textSecondary,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const JourneyScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomNeonButton(
                        text: 'ENTER AVATAR STORE',
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AvatarStoreScreen(
                              controller: widget.controller,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
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
