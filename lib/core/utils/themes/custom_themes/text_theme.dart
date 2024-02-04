import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black),
    headlineMedium: const TextStyle().copyWith(
      fontFamily: 'SignikaNegative',
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      height: 1.6,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontFamily: 'SignikaNegative',
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.6,
    ),
    titleLarge: const TextStyle().copyWith(
      fontFamily: 'SignikaNegative',
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: AppColors.whiteColor, // ElevatedButton text rengi
    ),
    titleMedium: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.black),
    bodyLarge: const TextStyle().copyWith(
      fontFamily: 'SignikaNegative',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary, // Input'un içinde yazı yazma rengi
    ),
    bodyMedium: const TextStyle().copyWith(
      fontFamily: 'SignikaNegative',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary, // Input text rengi
      height: 1.6,
    ),
    bodySmall: const TextStyle().copyWith(
      fontFamily: 'SignikaNegative',
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary.withOpacity(0.5),
      height: 2.26,
    ),
    labelLarge: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black.withOpacity(0.5)),
    displayLarge: const TextStyle(
        fontFamily: 'SignikaNegative',
        fontSize: 40,
        color: AppColors.primaryTextTextColor,
        fontWeight: FontWeight.w500,
        height: 1.6),
    displayMedium: const TextStyle(
        fontFamily: 'SignikaNegative',
        fontSize: 32,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
        height: 1.6),
    displaySmall: const TextStyle(
        fontFamily: 'SignikaNegative',
        fontSize: 28,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
        height: 1.6),
  );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    headlineMedium: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: Colors.white),
    headlineSmall: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white),
    titleLarge: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white), // ElevatedButton text rengi
    titleMedium: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.white),
    titleSmall: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white),
    bodyLarge: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor), // Input'un içinde yazı yazma rengi
    bodyMedium: const TextStyle().copyWith(
      fontFamily: 'SignikaNegative',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: AppColors.whiteColor, // Input text rengi
    ),
    bodySmall: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white),
    labelMedium: const TextStyle().copyWith(
        fontFamily: 'SignikaNegative',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withOpacity(0.5)),
    displayLarge: const TextStyle(
        fontFamily: 'SignikaNegative',
        fontSize: 40,
        color: AppColors.primaryTextTextColor,
        fontWeight: FontWeight.w500,
        height: 1.6),
    displayMedium: const TextStyle(
        fontFamily: 'SignikaNegative',
        fontSize: 32,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        height: 1.6),
    displaySmall: const TextStyle(
        fontFamily: 'SignikaNegative',
        fontSize: 28,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
        height: 1.6),
  );
}
