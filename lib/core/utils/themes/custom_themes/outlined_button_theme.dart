import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.primaryColor, // Buton yazı rengi
      side: const BorderSide(
          color: AppColors.primaryColor), // Buton Kenar kalınlığı rengi
      textStyle: const TextStyle(
          fontFamily: 'SignikaNegative',
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.primaryColor, // Buton yazı rengi
      backgroundColor: AppColors.whiteColor, // Buton arkaplan rengi
      side: const BorderSide(
          color: Colors.transparent), // Buton Kenar kalınlığı rengi
      textStyle: const TextStyle(
          fontFamily: 'SignikaNegative',
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
