import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/widgets/custom_neon_button.dart';
import 'package:voz_app/core/widgets/custom_snackbar.dart';
import 'package:voz_app/features/dashboard/main_layout_screen.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_cubit.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_state.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/reset_password_screen.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/sign_up_screen.dart';
import 'package:voz_app/features/onboarding_auth/presentation/widgets/custom_auth_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : null,
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
                      Text(
                        'WELCOME BACK',
                        style: TextStyle(
                          color: const Color(0XFFDF00FF),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,
                          height: 0.95,
                        ),
                      ),
                      SizedBox(height: 32.h),
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
                      SizedBox(height: 20.h),
                      CustomAuthTextField(
                        labelText: 'Password',
                        hintText: '••••••••',
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 14.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: const Color(0XFFDF00FF),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 28.h),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color(0XFF1E1E1E),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: const Color(0XFF4E4E4E),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Color(0XFF1E1E1E),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28.h),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: const Color(0XFF6E6E6E),
                                fontSize: 13.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: "Register →",
                                  style: TextStyle(
                                    color: const Color(0XFFDF00FF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthSuccess) {
                              CustomSnackBar.showSuccess(
                                context,
                                'Welcome back!',
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MainLayoutScreen(),
                                ),
                                (route) => false,
                              );
                            } else if (state is AuthFailur) {
                              CustomSnackBar.showError(context, state.message);
                            }
                          },
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;
                            return CustomNeonButton(
                              text: isLoading ? 'Logging in...' : 'Login',
                              onPressed: isLoading
                                  ? () {}
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().signIn(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text
                                              .trim(),
                                        );
                                      }
                                    },
                            );
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
