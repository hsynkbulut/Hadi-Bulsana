import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';

class RowTitleHome extends StatelessWidget {
  final VoidCallback onPress;
  final String title, subtitle;

  const RowTitleHome(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w700,
              color: dark ? AppColors.whiteColor : AppColors.black),
        ),
        InkWell(
          onTap: onPress,
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
