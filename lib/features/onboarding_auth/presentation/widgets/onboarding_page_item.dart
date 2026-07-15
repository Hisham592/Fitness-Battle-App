import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/features/onboarding_auth/data/models/onboarding_model.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel item;

  const OnboardingPageItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),

          Text(
            item.subTitle,
            style: TextStyle(
              color: AppColors.primaryNeon,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 8.h),

          Text(
            item.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            item.description,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
          ),
          SizedBox(height: 18.h),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Image.asset(item.imagePath, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
