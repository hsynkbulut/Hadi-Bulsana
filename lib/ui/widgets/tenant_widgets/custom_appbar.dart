import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/utils/gap.dart';
import 'package:hadi_bulsana/main.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onLocationTap;
  final bool isDark;
  final String? district;
  final String? city;

  const CustomAppBar({
    Key? key,
    this.onLocationTap,
    required this.isDark,
    required this.district,
    required this.city,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    //final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return AppBar(
      backgroundColor: isDark ? AppColors.dark : AppColors.bColor,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      toolbarHeight: 80,
      //Home page APP BAR , SALAM and Profile Icon
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  //_showLocationBottomSheet(); // Şehir ve ilçe seçim bottom sheet'i göster
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(7),
                      border:
                          Border.all(color: AppColors.black.withOpacity(0.2))),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.locationDot,
                    size: 18.0,
                    color: AppColors.darkGrey,
                  )),
                ),
              ),
              Gap(isWidth: true, isHeight: false, width: width * 0.03),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$district, $city',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.bColor : AppColors.darkGrey,
                        ),
                    /*
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.bColor : AppColors.darkGrey,
                      fontSize: 17,
                    ),
                    */
                  ),
                  Text(
                    'Konum',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.ratingColor
                              : AppColors.darkGrey,
                        ),
                    /*
                    style: TextStyle(
                        color:
                            isDark ? AppColors.ratingColor : AppColors.darkGrey,
                        fontSize: 15),
                        */
                  ),
                ],
              ),
            ],
          ),
          //SizedBox(width: width * 0.1),
          GestureDetector(
            onTap: () {
              // ThemeProvider'ı kullanarak toggleTheme() fonksiyonunu çağırma
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: isDark ? AppColors.whiteColor : AppColors.darkerGrey,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: AppColors.black.withOpacity(0.2))),
              child: Center(
                child: Icon(
                  isDark
                      ? Icons.sunny
                      : Icons.brightness_2, // Theme'e göre ikonu seç
                  color: isDark ? AppColors.ratingColor : AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
