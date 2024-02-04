import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';

class ShortTopModuleCard extends StatelessWidget {
  final Color background;
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const ShortTopModuleCard({
    Key? key,
    required this.background,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        width: width * 0.38,
        height: height * 0.2,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: AppColors.whiteColor, width: width * 0.02),
          /*
            boxShadow: [
              BoxShadow(
                  blurRadius: 50,
                  color: AppColors.black.withOpacity(.09),
                  offset: const Offset(10, 10))
            ]
            */
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 16),
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor)),
          Expanded(
              child: Icon(
            icon,
            size: 60,
            color: AppColors.whiteColor,
          )),
        ]),
      ),
    );
  }
}
