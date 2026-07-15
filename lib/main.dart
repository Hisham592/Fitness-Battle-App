import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/features/onboarding_auth/data/services/auth_firebase_service.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_cubit.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/onboarding_screen.dart';
import 'package:voz_app/firebase_options.dart';
import 'core/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        return BlocProvider(
          create: (context) => AuthCubit(AuthFirebaseService()),
          child: MaterialApp(
            title: 'VOZ',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: AppColors.background,
              fontFamily: 'VOZFont',
              appBarTheme: const AppBarTheme(
                surfaceTintColor: Colors.transparent,
                backgroundColor: AppColors.background,
                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: AppColors.cardBackground,
                selectedItemColor: AppColors.primaryNeon,
                unselectedItemColor: AppColors.textSecondary,
              ),
            ),
            home: OnboardingScreen(),
          ),
        );
      },
    );
  }
}
