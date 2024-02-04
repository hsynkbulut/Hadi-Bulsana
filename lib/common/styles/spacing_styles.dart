import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: TSizes.appBarHeight,
    left: TSizes.defaultSpace,
    bottom: TSizes.defaultSpace,
    right: TSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry paddingWithAppBarHeight2 = EdgeInsets.only(
    top: TSizes.lg,
    left: TSizes.spaceBtwItems,
    bottom: TSizes.spaceBtwItems,
    right: TSizes.spaceBtwItems,
  );
}
