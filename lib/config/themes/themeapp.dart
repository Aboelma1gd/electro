import 'package:electro/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeApp = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    background: AppColors.background,
    surface: AppColors.secondBackground,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Color.fromARGB(0, 0, 0, 0),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  fontFamily: 'CircularStd',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      minimumSize: const Size(double.infinity, 50),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.secondBackground,
    filled: true,
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 0),
      borderRadius: BorderRadius.circular(15),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0),
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
