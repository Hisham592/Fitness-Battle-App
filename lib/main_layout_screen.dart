import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/features/dashboard/dashboard_screen.dart';
import 'package:voz_app/features/nutrition/presentation/screens/smart_nutrition_screen.dart';
import 'package:voz_app/features/profile/controllers/profile_controller.dart';
import 'package:voz_app/features/profile/screens/profile_screen.dart';
import 'package:voz_app/features/workout/workout_screen.dart';

class MainLayoutController extends InheritedWidget {
  final void Function(int index) switchTab;

  const MainLayoutController({
    super.key,
    required this.switchTab,
    required super.child,
  });

  static MainLayoutController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainLayoutController>();
  }

  @override
  bool updateShouldNotify(MainLayoutController oldWidget) => false;
}

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    const WorkoutScreen(),
    const SmartNutritionScreen(),
    ProfileScreen(controller: ProfileController()),
  ];

  @override
  Widget build(BuildContext context) {
    final activeAccent = Theme.of(context).colorScheme.primary;

    return MainLayoutController(
      switchTab: _switchTab,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xff2E2E2E), width: 1.0),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF181818),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: activeAccent,
            unselectedItemColor: const Color(0xff555555),
            selectedLabelStyle: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/homeIcon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xff555555),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/homeIcon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    activeAccent,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/workoutIcon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xff555555),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/workoutIcon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    activeAccent,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'WORKOUT',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/nutritionIconActive.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xff555555),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/nutritionIconActive.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    activeAccent,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'NUTRITION',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/profileIcon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xff555555),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/profileIcon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    activeAccent,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'PROFILE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}