import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(const VozApp());
}

class VozApp extends StatelessWidget {
  const VozApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'VOZ',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.background,
            fontFamily: 'Rajdhani',
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.background,
              elevation: 0,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: AppColors.cardBackground,
              selectedItemColor: AppColors.primaryNeon,
              unselectedItemColor: AppColors.textSecondary,
            ),
          ),
          home: const Scaffold(
            body: Center(
              child: Text(
                'VOZ App Initialized',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
