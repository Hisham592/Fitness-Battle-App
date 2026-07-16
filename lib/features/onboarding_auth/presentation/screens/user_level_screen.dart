import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/widgets/custom_snackbar.dart';
import 'package:voz_app/features/dashboard/main_layout_screen.dart';
import 'package:voz_app/features/onboarding_auth/data/models/levels_model.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_cubit.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_state.dart';
import 'package:voz_app/features/onboarding_auth/presentation/widgets/level_card.dart';

class UserLevelScreen extends StatefulWidget {
  const UserLevelScreen({super.key});

  @override
  State<UserLevelScreen> createState() => _UserLevelScreenState();
}

class _UserLevelScreenState extends State<UserLevelScreen> {
  Level? selectedLevel;

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = selectedLevel != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Level',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28.h),
            Text(
              "Where do you\ncurrently stand?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "We'll build the perfect programme for your level.",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.separated(
                itemCount: levels.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final level = levels[index];
                  final isSelected = selectedLevel == level;

                  return LevelCard(
                    level: level,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedLevel = selectedLevel == level ? null : level;
                      });
                    },
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      CustomSnackBar.showSuccess(
                        context,
                        'Account Created Successfully!',
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainLayoutScreen(),
                        ),
                        (route) => false,
                      );
                    } else if (state is AuthFailur) {
                      CustomSnackBar.showError(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: isButtonEnabled && !isLoading
                            ? [
                                BoxShadow(
                                  color: AppColors.primaryNeon.withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: 15.r,
                                  spreadRadius: 1.r,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: ElevatedButton(
                        onPressed: isButtonEnabled && !isLoading
                            ? () {
                                context.read<AuthCubit>().registerAndSaveUser(
                                  selectedLevel: selectedLevel!.title,
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryNeon,
                          disabledBackgroundColor: const Color(0XFF1E1E1E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "CONTINUE",
                                style: TextStyle(
                                  color: isButtonEnabled
                                      ? Colors.black
                                      : Colors.grey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
