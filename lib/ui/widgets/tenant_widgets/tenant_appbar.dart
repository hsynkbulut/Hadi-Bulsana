import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';

class TenantAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDark;
  final bool showBackButton;

  const TenantAppBar({
    Key? key,
    required this.title,
    required this.isDark,
    required this.showBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDark ? AppColors.dark : AppColors.primaryColor,
      leading: showBackButton
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: isDark ? AppColors.whiteColor : AppColors.whiteColor,
              ),
            )
          : null,
      centerTitle: false,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: isDark ? AppColors.whiteColor : AppColors.whiteColor,
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
