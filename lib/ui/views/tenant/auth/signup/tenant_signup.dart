import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/constants/sizes.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/ui/views/tenant/auth/signup/widgets/tenant_signup_form.dart';

class TenantSignupScreen extends StatelessWidget {
  const TenantSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.black : AppColors.whiteColor,
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.all(2), //TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    height: 160,
                    image: AssetImage(dark
                        ? ImagePaths.darkAppLogo
                        : ImagePaths.lightAppLogo),
                  ),

                  /// Title

                  Text(TTexts.signUpTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: dark
                                  ? AppColors.whiteColor
                                  : AppColors.darkerGrey)),
                  const SizedBox(height: TSizes.spaceBtwSections / 2),
                ],
              ),

              /// Form
              const TenantSignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
