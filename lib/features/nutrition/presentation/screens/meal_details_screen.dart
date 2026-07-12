import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/meal.dart';
import '../widgets/macro_info_card.dart';

class MealDetailsScreen extends StatelessWidget {
  final Meal meal;
  const MealDetailsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final Color dynamicDishColor =
        meal.containerColor ?? AppColors.cardBackground;

    return Scaffold(
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
              color: Colors.grey.withOpacity(0.3),
              thickness: 1,
              height: 1,
            ),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100.h),
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
                          color: Colors.grey.withOpacity(0.3),
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
                                    highlightColor: const Color(0xffDF00FF),
                                    backgroundColor: Color(
                                      0xffDF00FF,
                                    ).withOpacity(0.09),
                                    borderColor: const Color(
                                      0xffDF00FF,
                                    ).withOpacity(0.4),
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
                                  color: Color(0xFFDF00FF),
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
                                  color: Color(0xFF777777),
                                  height: 1.5.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 20.w,
                    right: 20.w,
                    bottom: 25.h,
                    child: SizedBox(
                      height: 52.h,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffDF00FF).withOpacity(0.25),
                              offset: const Offset(0, 0),
                              blurRadius: 48.r,
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: const Color(0xffDF00FF).withOpacity(0.60),
                              offset: const Offset(0, 0),
                              blurRadius: 24.r,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryNeon,
                            foregroundColor: const Color(0xFF111111),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(
                                0xFF1C1C1C,
                              ), // Matches your card backgrounds
                              behavior: SnackBarBehavior
                                  .floating, // Allows radius and margin configurations
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                side: const BorderSide(
                                  color: Color(
                                    0xffDF00FF,
                                  ), // Your signature neon purple accent border
                                  width: 1,
                                ),
                              ),
                              margin: EdgeInsets.only(
                                bottom: 90
                                    .h, // Clear height to prevent overlapping the floating action button
                                left: 20.w,
                                right: 20.w,
                              ),
                              duration: const Duration(seconds: 2),
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: Color(0xffDF00FF),
                                    size: 20,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      '${meal.title.toUpperCase()} MARKED!',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white.withOpacity(0.95),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'MARK MEAL AS EATEN →',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.96,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
