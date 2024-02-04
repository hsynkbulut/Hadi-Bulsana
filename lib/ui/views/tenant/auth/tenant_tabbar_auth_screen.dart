import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/ui/views/tenant/auth/login/tenant_login.dart';
import 'package:hadi_bulsana/ui/views/tenant/auth/signup/tenant_signup.dart';

class TenantTabbarAuthScreen extends StatefulWidget {
  const TenantTabbarAuthScreen({super.key});

  @override
  State<TenantTabbarAuthScreen> createState() => _TenantTabbarAuthScreenState();
}

class _TenantTabbarAuthScreenState extends State<TenantTabbarAuthScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    final Size screenSize = THelperFunctions.screenSize(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
                color: dark ? AppColors.whiteColor : AppColors.black),
            centerTitle: true,
            title: Text(
              'Kiracı',
              style: TextStyle(
                color: dark ? AppColors.whiteColor : AppColors.black,
                fontFamily: 'SignikaNegative',
                fontSize: 25,
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: dark ? AppColors.black : AppColors.whiteColor,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.08,
                vertical: screenSize.height * 0.02),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.01),
                Container(
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicatorColor:
                        dark ? AppColors.primaryColor : AppColors.primaryColor,
                    labelColor:
                        dark ? AppColors.primaryColor : AppColors.primaryColor,
                    unselectedLabelColor:
                        dark ? AppColors.whiteColor : AppColors.darkerGrey,
                    tabs: const [
                      Tab(
                        text: 'Giriş',
                      ),
                      Tab(
                        text: 'Kayıt',
                      ),
                    ],
                  ),
                ),
                const Expanded(
                    child: TabBarView(
                  children: [
                    TenantLoginScreen(),
                    TenantSignupScreen(),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
