import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voz_app/core/theme/app_theme.dart';
import 'package:voz_app/core/theme/theme_cubit.dart';
import 'package:voz_app/main_layout_screen.dart';
import 'package:voz_app/features/onboarding_auth/data/services/auth_firebase_service.dart';
import 'package:voz_app/features/onboarding_auth/logic/auth_cubit/auth_cubit.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/onboarding_screen.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/sign_in_screen.dart';
import 'package:voz_app/firebase_options.dart';

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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit(AuthFirebaseService())),
            BlocProvider(create: (context) => ThemeCubit()),
          ],
          child: BlocBuilder<ThemeCubit, Color>(
            builder: (context, accentColor) {
              return MaterialApp(
                title: 'VOZ',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.getTheme(accentColor),
                home: isFirstTime
                    ? const OnboardingScreen()
                    : StreamBuilder<User?>(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(
                                  color: accentColor,
                                ),
                              ),
                            );
                          }
                          if (snapshot.hasData && snapshot.data != null) {
                            return const MainLayoutScreen();
                          }
                          return const SignInScreen();
                        },
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
