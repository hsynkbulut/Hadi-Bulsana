import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.primaryColor, // ElevatedButton arkaplan rengi
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.transparent),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontFamily: 'SignikaNegative',
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primaryColor, // ElevatedButton arkaplan rengi
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: AppColors.primaryColor,
      side: const BorderSide(color: Colors.transparent),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontFamily: 'SignikaNegative',
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
