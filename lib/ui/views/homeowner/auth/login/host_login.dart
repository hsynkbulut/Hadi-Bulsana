import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/ui/views/homeowner/auth/login/widgets/host_login_form.dart';
import 'package:hadi_bulsana/ui/views/homeowner/auth/login/widgets/host_login_header.dart';

class HostLoginScreen extends StatelessWidget {
  const HostLoginScreen({super.key});

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
              HostLoginHeader(),

              /// Form
              HostLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
