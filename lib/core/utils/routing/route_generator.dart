// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';
import 'package:hadi_bulsana/ui/views/chooseProfile/choose_profile.dart';
import 'package:hadi_bulsana/ui/views/homeowner/about/about_page_homeowner.dart';
import 'package:hadi_bulsana/ui/views/homeowner/add_house_listings/add_house_listing.dart';
import 'package:hadi_bulsana/ui/views/homeowner/auth/host_tabbar_auth_screen.dart';
import 'package:hadi_bulsana/ui/views/homeowner/delete_house_listings/delete_house_listing.dart';
import 'package:hadi_bulsana/ui/views/homeowner/get_house_listings/get_house_listings.dart';
import 'package:hadi_bulsana/ui/views/homeowner/get_rented_house_listings/get_rented_house_listing_screen.dart';
import 'package:hadi_bulsana/ui/views/homeowner/home/host_dashboard.dart';
import 'package:hadi_bulsana/ui/views/homeowner/profile_page/home_owner_profile_page.dart';
import 'package:hadi_bulsana/ui/views/homeowner/update_house_listings/update_house_listing.dart';
import 'package:hadi_bulsana/ui/views/tenant/auth/tenant_tabbar_auth_screen.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/custom_bottom_navbar.dart';
import 'package:hadi_bulsana/ui/views/onboard/onboard.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.onBoardScreenRoute:
        return MaterialPageRoute(builder: (_) => OnboardScreen());
      case RouteConstant.chooseProfileRoute:
        return MaterialPageRoute(builder: (_) => const ChooseProfile());
      case RouteConstant.tabbarTenantAuthRoute:
        return MaterialPageRoute(
            builder: (_) => const TenantTabbarAuthScreen());
      case RouteConstant.bottomNaviRoute:
        return MaterialPageRoute(builder: (_) => CustomBottomNavBar());
      case RouteConstant.tabbarHostAuthRoute:
        return MaterialPageRoute(builder: (_) => const HostTabbarAuthScreen());
      case RouteConstant.hostDashboardRoute:
        return MaterialPageRoute(builder: (_) => const HostDashboard());
      case RouteConstant.addHouseListingRoute:
        return MaterialPageRoute(builder: (_) => AddHouseListingsScreen());
      case RouteConstant.getHouseListingRoute:
        return MaterialPageRoute(builder: (_) => GetHouseListingScreen());
      case RouteConstant.deleteHouseListingRoute:
        return MaterialPageRoute(builder: (_) => DeleteHouseListingScreen());
      case RouteConstant.updateHouseListingRoute:
        return MaterialPageRoute(builder: (_) => UpdateHouseListingScreen());
      case RouteConstant.homeOwnerAboutRoute:
        return MaterialPageRoute(builder: (_) => HomeOwnerAboutPage());
      case RouteConstant.homeOwnerProfileRoute:
        return MaterialPageRoute(builder: (_) => HomeOwnerProfilePage());
      case RouteConstant.getRentedHouseListingRoute:
        return MaterialPageRoute(builder: (_) => GetRentedHouseListingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Ters giden birşeyler oldu'),
            ),
          ),
        );
    }
  }
}
