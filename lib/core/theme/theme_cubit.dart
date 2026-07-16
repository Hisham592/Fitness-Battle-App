import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';

class ThemeCubit extends Cubit<Color> {
  static const String _themeKey = 'accent_color_value';

  ThemeCubit() : super(AppColors.neonPurple) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedColorValue = prefs.getInt(_themeKey);
    if (savedColorValue != null) {
      emit(Color(savedColorValue));
    }
  }

  Future<void> setAccentColor(Color color) async {
    emit(color);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, color.toARGB32());
  }
}
