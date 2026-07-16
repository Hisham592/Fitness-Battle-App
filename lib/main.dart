import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voz_app/features/onboarding_auth/data/services/auth_firebase_service.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_cubit.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/onboarding_screen.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/sign_in_screen.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/temp_dashboard_screen.dart';
import 'package:voz_app/firebase_options.dart';
import 'core/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(VozApp(isFirstTime: isFirstTime));
}

class VozApp extends StatelessWidget {
  const VozApp({super.key, required this.isFirstTime});
  
  final bool isFirstTime;

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
            ),
            home: isFirstTime
                ? const OnboardingScreen()
                : StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryNeon,
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        return const TempDashboardScreen();
                      }
                      return const SignInScreen();
                    },
                  ),
          ),
        );
      },
    );
  }
}