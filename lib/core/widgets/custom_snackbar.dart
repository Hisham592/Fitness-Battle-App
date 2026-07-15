import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';

class CustomSnackBar {
  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: const Color(0XFF1e1120),
      borderColor: const Color(0XFFDF00FF),
      icon: Icons.check_circle_rounded,
      iconColor: const Color(0XFFDF00FF),
    );
  }

  static void showError(BuildContext context, String rawError) {
    final cleanMessage = _translateFirebaseError(rawError);
    _show(
      context,
      message: cleanMessage,
      backgroundColor: const Color(0XFF1C0D0D),
      borderColor: Colors.redAccent,
      icon: Icons.error_outline_rounded,
      iconColor: Colors.redAccent,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Color borderColor,
    required IconData icon,
    required Color iconColor,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: borderColor.withValues(alpha: 0.3),
              width: 1.w,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _translateFirebaseError(String error) {
    final lowerError = error.toLowerCase();

    if (lowerError.contains('user-not-found') ||
        lowerError.contains('invalid-credential')) {
      return 'Incorrect email or password. Please try again.';
    } else if (lowerError.contains('wrong-password')) {
      return 'Incorrect password. Please try again.';
    } else if (lowerError.contains('email-already-in-use')) {
      return 'This email is already registered. Try logging in.';
    } else if (lowerError.contains('weak-password')) {
      return 'The password is too weak. Please use at least 8 characters.';
    } else if (lowerError.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    } else if (lowerError.contains('network-request-failed')) {
      return 'No internet connection. Please check your network.';
    } else if (lowerError.contains('too-many-requests')) {
      return 'Too many attempts. Please try again later.';
    }

    return 'Something went wrong. Please try again.';
  }
}
