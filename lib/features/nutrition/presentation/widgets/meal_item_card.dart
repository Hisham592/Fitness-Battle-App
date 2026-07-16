import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/meal.dart';

class MealItemCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final Color graphicContainerColor;

  const MealItemCard({
    super.key,
    required this.meal,
    required this.onTap,
    this.graphicContainerColor = const Color(0xFF111A11),
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xff2E2E2E), width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: 68.w,
              height: 76.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: graphicContainerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  bottomLeft: Radius.circular(14.r),
                ),
              ),
              child: Text(meal.graphic, style: TextStyle(fontSize: 30.sp)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      SizedBox(width: 4.w),
                      Text(
                        '${meal.calories} kcal',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.40),
                    offset: const Offset(0, 0),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                '${meal.priceEgp.toStringAsFixed(0)} EGP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
