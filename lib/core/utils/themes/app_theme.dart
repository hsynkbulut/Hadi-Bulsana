import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/utils/themes/custom_themes/appbar_theme.dart';
import 'package:hadi_bulsana/core/utils/themes/custom_themes/bottom_sheet_theme.dart';
import 'package:hadi_bulsana/core/utils/themes/custom_themes/checkbox_theme.dart';
import 'package:hadi_bulsana/core/utils/themes/custom_themes/chip_theme.dart';
import 'package:hadi_bulsana/core/utils/themes/custom_themes/elevated_button_theme.dart';
import 'package:hadi_bulsana/core/utils/themes/custom_themes/outlined_button_theme.dart';
import 'package:hadi_bulsana/core/utils/themes/custom_themes/text_field_theme.dart';
import 'package:hadi_bulsana/core/utils/themes/custom_themes/text_theme.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    primarySwatch: AppColors.primaryMaterialColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
