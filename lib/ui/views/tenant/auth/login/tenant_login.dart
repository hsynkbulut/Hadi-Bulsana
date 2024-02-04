import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/ui/views/tenant/auth/login/widgets/tenant_login_form.dart';
import 'package:hadi_bulsana/ui/views/tenant/auth/login/widgets/tenant_login_header.dart';

class TenantLoginScreen extends StatelessWidget {
  const TenantLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.black : AppColors.whiteColor,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2), //TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title & Sub-Title
              TenantLoginHeader(),

              /// Form
              TenantLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
