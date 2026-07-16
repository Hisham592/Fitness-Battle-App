import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/core/widgets/custom_snackbar.dart';
import 'package:voz_app/features/onboarding_auth/data/models/user_model.dart';

import '../controllers/profile_controller.dart';
import '../models/avatar_model.dart';
import '../widgets/avatar_tile.dart';

class AvatarStoreScreen extends StatefulWidget {
  final ProfileController controller;

  const AvatarStoreScreen({super.key, required this.controller});

  @override
  State<AvatarStoreScreen> createState() => _AvatarStoreScreenState();
}

class _AvatarStoreScreenState extends State<AvatarStoreScreen> {
  final List<AvatarModel> _storeAvatars = [
    AvatarModel(id: 'lion', name: 'LION', emoji: '🦁', cost: 0, unlocked: true),
    AvatarModel(id: 'wolf', name: 'WOLF', emoji: '🐺', cost: 800),
    AvatarModel(id: 'eagle', name: 'EAGLE', emoji: '🦅', cost: 600),
    AvatarModel(id: 'dragon', name: 'DRAGON', emoji: '🐉', cost: 1200),
    AvatarModel(id: 'fox', name: 'FOX', emoji: '🦊', cost: 400),
    AvatarModel(id: 'tiger', name: 'TIGER', emoji: '🐯', cost: 1000),
  ];

  Future<void> _handleAvatarTap(
    BuildContext context,
    AvatarModel avatar,
    UserModel user,
  ) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final primaryColor = Theme.of(context).colorScheme.primary;

    final bool isUnlocked = user.unlockedAvatars.contains(avatar.emoji) ||
        user.unlockedAvatars.contains(avatar.id) ||
        avatar.cost == 0;
    final bool isActive =
        user.activeAvatar == avatar.emoji || user.activeAvatar == avatar.id;

    if (isActive) {
      return;
    }

    if (isUnlocked) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'activeAvatar': avatar.emoji,
      });
      if (context.mounted) {
        CustomSnackBar.showSuccess(context, "Avatar equipped successfully!");
      }
      return;
    }

    if (user.points < avatar.cost) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          backgroundColor: AppColors.danger,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          content: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  "Not enough points! You need more PTS to unlock this avatar.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      return;
    }

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final int remainingPoints = user.points - avatar.cost;
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: const BorderSide(color: AppColors.surfaceBorder),
          ),
          title: Text(
            'Confirm Purchase',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unlock ${avatar.name} ${avatar.emoji}?',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Total:',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    '${user.points} PTS',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Item Cost:',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    '-${avatar.cost} PTS',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Divider(color: AppColors.surfaceBorder, height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remaining Balance:',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    '$remainingPoints PTS',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(
                'Confirm Purchase',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'points': FieldValue.increment(-avatar.cost),
        'unlockedAvatars': FieldValue.arrayUnion([avatar.emoji, avatar.id]),
        'activeAvatar': avatar.emoji,
      });

      if (context.mounted) {
        CustomSnackBar.showSuccess(context, "Avatar purchased successfully!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitleWidget(title: "AVATAR STORE"),
        centerTitle: true,
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
                  'Error fetching store data',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              );
            }

            final user = UserModel.fromMap(
              snapshot.data!.data() as Map<String, dynamic>,
            );

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt, color: primaryColor, size: 18.sp),
                          SizedBox(width: 6.w),
                          Text(
                            '${user.points} PTS AVAILABLE',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _storeAvatars.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14.h,
                        crossAxisSpacing: 14.w,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        final avatarItem = _storeAvatars[index];
                        final bool isUnlocked =
                            user.unlockedAvatars.contains(avatarItem.emoji) ||
                                user.unlockedAvatars.contains(avatarItem.id) ||
                                avatarItem.cost == 0;
                        final bool isActive =
                            user.activeAvatar == avatarItem.emoji ||
                                user.activeAvatar == avatarItem.id;

                        final displayAvatar = AvatarModel(
                          id: avatarItem.id,
                          name: avatarItem.name,
                          emoji: avatarItem.emoji,
                          cost: avatarItem.cost,
                          unlocked: isUnlocked,
                        );

                        return AvatarTile(
                          avatar: displayAvatar,
                          isActive: isActive,
                          onTap: () => _handleAvatarTap(
                            context,
                            avatarItem,
                            user,
                          ),
                        );
                      },
                    ),
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
