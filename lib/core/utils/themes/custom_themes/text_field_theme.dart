import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.primaryColor,
    suffixIconColor: AppColors.primaryColor,
    labelStyle:
        const TextStyle().copyWith(fontSize: 14, color: AppColors.black),
    hintStyle:
        const TextStyle().copyWith(fontSize: 14, color: AppColors.primaryColor),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, color: AppColors.error),
    floatingLabelStyle: const TextStyle().copyWith(
        color: AppColors.primaryColor.withOpacity(
            0.8)), //İnput'a tıklayınca yukarı çıkan minik text rengi
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.black),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.primaryColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 2, color: Colors.orange),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.whiteColor,
    suffixIconColor: AppColors.whiteColor,
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, color: AppColors.error),
    floatingLabelStyle: const TextStyle().copyWith(
        color: AppColors.whiteColor.withOpacity(
            0.8)), //İnput'a tıklayınca yukarı çıkan minik text rengi
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.primaryColor),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.whiteColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 2, color: Colors.orange),
    ),
  );
}
