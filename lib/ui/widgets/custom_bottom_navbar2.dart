/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/ui/views/tenant/account/tenant_account_page.dart';
import 'package:hadi_bulsana/ui/views/tenant/home/homepage.dart';
import 'package:hadi_bulsana/ui/views/tenant/favorite/favorite_screen.dart';

class CustomBottomNavbar2 extends StatefulWidget {
  const CustomBottomNavbar2({Key? key}) : super(key: key);
  @override
  State<CustomBottomNavbar2> createState() => _CustomBottomNavbar2State();
}

class _CustomBottomNavbar2State extends State<CustomBottomNavbar2> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Saved(),
    TenantAccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.deepPurple[300]!,
              hoverColor: Colors.deepPurple[100]!,
              gap: 8,
              tabBorderRadius: 15,
              activeColor: AppColors.primaryColor,
              iconSize: 23,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              //tabBackgroundColor: Colors.deepPurple[100]!,
              color: Colors.black45,
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  //text: 'Anasayfa',
                ),
                GButton(
                  icon: FontAwesomeIcons.heart,
                  //text: 'Favoriler',
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  //text: 'Hesabım',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
*/