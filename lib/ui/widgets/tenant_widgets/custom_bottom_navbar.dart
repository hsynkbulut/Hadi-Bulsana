import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/ui/views/tenant/account/tenant_account_page.dart';
import 'package:hadi_bulsana/ui/views/tenant/favorite/favorite_screen.dart';
import 'package:hadi_bulsana/ui/views/tenant/home/homepage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: const [
          HomePage(),
          //SearchPage(),
          Saved(),
          TenantAccountPage(),
        ],
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style12,
        // navBarStyle: NavBarStyle.style1,
        // navBarStyle: NavBarStyle.style2,
        // navBarStyle: NavBarStyle.style3,
        // navBarStyle: NavBarStyle.style5,
        // navBarStyle: NavBarStyle.style6,
        // navBarStyle: NavBarStyle.style8,
        // navBarStyle: NavBarStyle.style9,
        // navBarStyle: NavBarStyle.style11,
        // navBarStyle: NavBarStyle.style13,
        // navBarStyle: NavBarStyle.style14,
        // navBarStyle: NavBarStyle.style17,
        // navBarStyle: NavBarStyle.style18,
        backgroundColor: dark ? AppColors.dark : AppColors.whiteColor,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final dark = THelperFunctions.isDarkMode(context);
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.home_2,
          size: 24,
        ),
        title: ("Ana Sayfa"),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      /*
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.search_normal_1,
          size: 24,
        ), //FontAwesomeIcons.bell
        title: ("Arama"),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      */
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.heart,
          size: 24,
        ),
        title: ("Favoriler"),
        //textStyle: TextStyle(fontSize: 10),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.user,
          size: 24,
        ), //FontAwesomeIcons.bell
        title: ("Hesabım"),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
    ];
  }
}
