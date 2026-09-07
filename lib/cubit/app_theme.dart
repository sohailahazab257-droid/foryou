import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  //light
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor:
    AppColors.lightBackground,
    primaryColor:
    AppColors.lightPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightAppBar,
      foregroundColor: AppColors.lightText,),
    cardTheme: const CardThemeData(
      color: AppColors.lightCard,),
    iconTheme: const IconThemeData(
      color: AppColors.lightIcon,),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.lightText,
      ),
      bodyMedium: TextStyle(
        color: AppColors.lightText,
      ),
      bodySmall: TextStyle(
        color: AppColors.lightSecondaryText,
      ),
    ),
  );

//dark

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor:
    AppColors.darkBackground,
    primaryColor:
    AppColors.darkPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkAppBar,
      foregroundColor: AppColors.darkText,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.darkCard,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.darkIcon,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.darkText,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkText,
      ),
      bodySmall: TextStyle(
        color: AppColors.darkSecondaryText,
      ),
    ),
  );
}