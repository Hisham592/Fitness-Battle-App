import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/features/nutrition/domain/entities/meal.dart';
import 'package:voz_app/features/nutrition/presentation/widgets/macro_info_card.dart';

class MealDetailsScreen extends StatelessWidget {
  final Meal meal;
  const MealDetailsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final Color dynamicDishColor = meal.containerColor;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/arrowBack.svg',
                      width: 18.w,
                      height: 18.h,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 48.w),
                        child: Text(
                          'MEAL DETAILS',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.05,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withValues(alpha: 0.3),
              thickness: 1,
              height: 1,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 190.h,
                        decoration: BoxDecoration(
                          color: dynamicDishColor,
                          shape: BoxShape.rectangle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          meal.graphic,
                          style: TextStyle(fontSize: 55.sp),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.withValues(alpha: 0.3),
                      thickness: 1,
                      height: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 25.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal.title.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.75,
                            ),
                          ),
                          Text(
                            "High-protein Egyptian style",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 25.h),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 1.61,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              MacroInfoCard(
                                value: '${meal.calories}',
                                unit: 'kcal',
                                label: 'Calories',
                              ),
                              MacroInfoCard(
                                label: 'Price',
                                value: meal.priceEgp.toStringAsFixed(0),
                                unit: 'EGP',
                                highlightColor: primaryColor,
                                backgroundColor: primaryColor.withValues(
                                  alpha: 0.09,
                                ),
                                borderColor: primaryColor.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                              MacroInfoCard(
                                label: 'Protein',
                                value: '${meal.proteinGrams}g',
                                unit: '',
                              ),
                              MacroInfoCard(
                                label: 'Carbs',
                                value: '${meal.carbsGrams}g',
                                unit: '',
                              ),
                              MacroInfoCard(
                                label: 'Fats',
                                value: '${meal.fatsGrams}g',
                                unit: '',
                              ),
                              MacroInfoCard(
                                label: 'Prep Time',
                                value: meal.prepTime,
                                unit: '',
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            'PREPARATION',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                              letterSpacing: 1.68,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            meal.instructions.isEmpty
                                ? 'No preparation instructions available.'
                                : meal.instructions,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFF777777),
                              height: 1.5.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}