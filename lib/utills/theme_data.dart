import 'package:flutter/material.dart';
import 'package:note_sphere/utills/colors.dart';

class ThemeClass {
  static ThemeData dartTheme = ThemeData(
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppColors.kBgColor,
    colorScheme: ColorScheme.dark().copyWith(primary: AppColors.kWhiteColor),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBgColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.kWhiteColor),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.kFabColor,
    ),
  );
}
