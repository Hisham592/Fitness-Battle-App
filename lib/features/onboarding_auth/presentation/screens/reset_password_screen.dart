import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/widgets/custom_neon_button.dart';
import 'package:voz_app/features/onboarding_auth/presentation/widgets/custom_auth_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "RESET\nPASSWORD",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,
                          height: 0.95,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Enter your email address and we'll send you a secure reset link to regain access.",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13.sp,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0XFF1e1120),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: const Color(
                              0XFFDF00FF,
                            ).withValues(alpha: 0.2),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/outlineVoltIcon.svg",
                              width: 12.w,
                              height: 14.w,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                "Secure link expires in 24 hours. Please also check your spam folder.",
                                style: TextStyle(
                                  color: const Color(0XFFAEAEAE),
                                  fontSize: 12.sp,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 28.h),
                      CustomAuthTextField(
                        labelText: 'Email Address',
                        hintText: 'example@gmail.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                        child: CustomNeonButton(
                          text: 'Send Reset Link',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
