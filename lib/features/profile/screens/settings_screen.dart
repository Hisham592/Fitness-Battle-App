import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/theme/theme_cubit.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/sign_in_screen.dart';
import 'package:voz_app/features/profile/controllers/profile_controller.dart';

class SettingsScreen extends StatefulWidget {
  final ProfileController controller;

  const SettingsScreen({super.key, required this.controller});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: AppColors.surfaceBorder),
        ),
        title: Text(
          'Log Out',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Log Out',
              style: TextStyle(
                color: AppColors.danger,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false,
        );
      }
    }
  }

  void _showThemeSelector(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final currentColor = themeCubit.state;

    final List<Map<String, dynamic>> neonOptions = [
      {'name': 'Purple', 'color': AppColors.neonPurple},
      {'name': 'Cyan', 'color': AppColors.neonCyan},
      {'name': 'Green', 'color': AppColors.neonGreen},
      {'name': 'Yellow', 'color': AppColors.neonYellow},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        side: const BorderSide(color: AppColors.surfaceBorder),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Accent Color',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: neonOptions.map((opt) {
                  final Color color = opt['color'];
                  final String name = opt['name'];
                  final bool isSelected = color == currentColor;

                  return GestureDetector(
                    onTap: () {
                      themeCubit.setAccentColor(color);
                      Navigator.pop(ctx);
                    },
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 3.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.6),
                                blurRadius: isSelected ? 16.r : 8.r,
                              ),
                            ],
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check_rounded,
                                  color: Colors.black,
                                  size: 24.sp,
                                )
                              : null,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          name,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontSize: 11.sp,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  String _getColorName(Color color) {
    if (color == AppColors.neonCyan) return 'Electric Cyan';
    if (color == AppColors.neonGreen) return 'Volt Green';
    if (color == AppColors.neonYellow) return 'Volt Yellow';
    return 'Neon Purple';
  }

  @override
  Widget build(BuildContext context) {
    final activeAccent = Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const AppBarTitleWidget(title: "SETTINGS"),
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
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              children: [
                const _SectionLabel('PREFERENCES'),
                SizedBox(height: 10.h),
                _SettingsCard(
                  child: SwitchListTile(
                    value: widget.controller.pushNotificationsEnabled,
                    onChanged: widget.controller.togglePushNotifications,
                    activeThumbColor: Colors.white,
                    activeTrackColor: activeAccent,
                    title: Text(
                      'Push Notifications',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    subtitle: Text(
                      'Daily workout reminders',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13.sp,
                      ),
                    ),
                    secondary: Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.textSecondary,
                      size: 22.sp,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _showThemeSelector(context),
                  child: _SettingsCard(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'App Theme',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  _getColorName(activeAccent),
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: activeAccent,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.chevron_right,
                            color: AppColors.textSecondary,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                _SettingsCard(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'App Version',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                widget.controller.appVersion,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'LATEST',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                const _SectionLabel('ACCOUNT'),
                SizedBox(height: 10.h),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _confirmLogout,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.danger.withValues(alpha: 0.4),
                        width: 1.w,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: AppColors.danger,
                          size: 22.sp,
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Text(
                            'LOG OUT',
                            style: TextStyle(
                              color: AppColors.danger,
                              fontWeight: FontWeight.w800,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.danger,
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;
  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: AppColors.surfaceBorder, width: 1.w),
      ),
      child: child,
    );
  }
}
