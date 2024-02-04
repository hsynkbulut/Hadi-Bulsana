import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';

class TenantLoginHeader extends StatelessWidget {
  const TenantLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          height: 180,
          image: AssetImage(
              dark ? ImagePaths.darkAppLogo : ImagePaths.lightAppLogo),
        ),
        Text(TTexts.tenantLoginTitle,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.darkerGrey)),
        const SizedBox(height: TSizes.sm),
        Text(TTexts.tenantLoginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
