import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';

class CustomNeonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomNeonButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: AppColors.primaryNeon.withValues(alpha: 0.4),
                  blurRadius: 15.r,
                  spreadRadius: 1.r,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryNeon,
          disabledBackgroundColor: const Color(0XFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toUpperCase(),
              style: TextStyle(
                color: isEnabled ? Colors.black : Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_rounded,
              color: isEnabled ? Colors.black : Colors.grey,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
