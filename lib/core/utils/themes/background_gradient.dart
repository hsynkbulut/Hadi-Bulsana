import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';

class BackgroundGradient {
  BoxDecoration buildGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.dark, AppColors.dark],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(45),
        topRight: Radius.circular(45),
      ),
    );
  }

  BoxDecoration buildGradient2() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.whiteColor, AppColors.bColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(45),
        topRight: Radius.circular(45),
      ),
    );
  }
}
