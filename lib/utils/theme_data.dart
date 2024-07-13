import 'package:f24_notes_sphere/utils/colors.dart';
import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppColors.kBgColor,
    colorScheme: const ColorScheme.dark().copyWith(
      // copyWith use for overwrite defaults with our settings
      primary: AppColors.kWhiteColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.kBgColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.kWhiteColor,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.kFlaButColor,
    ),
  );
}
