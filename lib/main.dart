import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(const VozApp());
}

class VozApp extends StatelessWidget {
  const VozApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VOZ',
      debugShowCheckedModeBanner: false,
      // هنا بنثبت الثيم الداكن للتطبيق كله
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
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

      home: const Scaffold(body: Center(child: Text('VOZ App Initialized'))),
    );
  }
}
