import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/features/onboarding_auth/data/models/onboarding_model.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/sign_in_screen.dart';
import 'package:voz_app/features/onboarding_auth/presentation/widgets/onboarding_page_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: onboardingPages.length, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onNextPressed() async {
  if (_currentIndex < onboardingPages.length - 1) {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  } else {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false,
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentIndex == onboardingPages.length - 1;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _tabController.animateTo(index);
                });
              },
              itemBuilder: (context, index) {
                return OnboardingPageItem(item: onboardingPages[index]);
              },
            ),
          ),

          SizedBox(height: 16.h),

          TabPageSelector(
            controller: _tabController,
            color: AppColors.cardBackground,
            selectedColor: AppColors.primaryNeon,
            borderStyle: BorderStyle.none,
            indicatorSize: 8.r,
          ),

          SizedBox(height: 24.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              width: double.infinity,
              height: 52.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryNeon,
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _onNextPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNeon,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLastPage ? 'GET STARTED' : 'NEXT',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
