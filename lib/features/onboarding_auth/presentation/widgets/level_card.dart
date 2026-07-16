import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/features/onboarding_auth/data/models/levels_model.dart';

class LevelCard extends StatelessWidget {
  final Level level;
  final bool isSelected;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 88.h,
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(10.r),

          border: Border.all(
            color: isSelected ? AppColors.primaryNeon : const Color(0XFF2E2E2E),
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0XFF222222),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Image.asset(level.imagePath, fit: BoxFit.contain),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  level.title.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  level.description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
