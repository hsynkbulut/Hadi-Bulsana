import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';

class CustomAppBarWithButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool isDark;
  final bool showBackButton;
  final Function()? onFilterPressed;

  const CustomAppBarWithButton({
    Key? key,
    required this.title,
    required this.isDark,
    required this.showBackButton,
    this.onFilterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = THelperFunctions.screenWidth(context);

    return AppBar(
      backgroundColor: isDark ? AppColors.dark : AppColors.primaryColor,
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: isDark ? AppColors.whiteColor : AppColors.whiteColor,
              ),
        ),
      ),
      leading: showBackButton
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: isDark ? AppColors.whiteColor : AppColors.whiteColor,
              ),
            )
          : null,
      actions: [
        if (onFilterPressed != null)
          GestureDetector(
            onTap: onFilterPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.black.withOpacity(0.2)),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.list,
                    size: 18.0,
                    color: isDark ? AppColors.dark : AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
