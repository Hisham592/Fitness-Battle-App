import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/dashboard_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const VozFitnessApp());
}

class VozFitnessApp extends StatelessWidget {
  const VozFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VOZ Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.barlowTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.pink,
          brightness: Brightness.dark,
          primary: AppColors.pink,
          surface: AppColors.background,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
