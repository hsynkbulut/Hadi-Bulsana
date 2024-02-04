import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color black = Colors.black;

  static const MaterialColor primaryMaterialColor = MaterialColor(
    0xff58ee4a,
    <int, Color>{
      50: Color(0xff58ee4a),
      100: Color(0xff58ee4a),
      200: Color(0xff58ee4a),
      300: Color(0xff58ee4a),
      400: Color(0xff58ee4a),
      500: Color(0xff58ee4a),
      600: Color(0xff58ee4a),
      700: Color(0xff58ee4a),
      800: Color(0xff58ee4a),
      900: Color(0xff58ee4a),
    },
  );

  //===================================================

  // App Basic Colors
  static const Color primaryColor = Color(0XFFA873EB); //Color(0xff244cb3);
  static const Color primaryColor2 = Color(0xFFCD0E2E);
  static const Color primary = Color(0xFF4b68ff);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xffff9a9e),
        Color(0xfffad0c4),
        Color(0xfffad0c4),
      ]);

  // Text Colors
  static const Color textPrimary = Color(0XFFA873EB); //Color(0xff244cb3);
  static const Color textPrimary2 = Color(0xFFCD0E2E);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;
  static const Color primaryTextTextColor = Color(0xff242424);

  // Background Colors
  static const Color bColor = Color(0xfff3f6fb);
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container Class
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = AppColors.whiteColor.withOpacity(0.1);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF0371DE);
  static const Color ratingColor = Color(0xFFFFE24B);

  // Neutral Shades
  //static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color whiteColor = Color(0xffffffff);
}
