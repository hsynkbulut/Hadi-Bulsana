/*
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi ve gradyan
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePaths.onboardImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.primaryColor.withOpacity(0.9),
                    AppColors.primaryColor.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // İçerik
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  TTexts.onBoardingTitle1,
                  style: TextStyle(
                    fontFamily: 'SignikaNegative',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  TTexts.onBoardingSubTitle1,
                  style: TextStyle(
                    fontFamily: 'SignikaNegative',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Skip button action
                      },
                      child: const Text(
                        TTexts.skip,
                        style: TextStyle(
                          fontFamily: 'SignikaNegative',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white)),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouteConstant.chooseProfileRoute);
                      },
                      child: SizedBox(
                        child: Container(
                          width: 100,
                          height: 20.0, // veya istediğiniz yükseklik
                          alignment: Alignment.center,
                          child: Text(TTexts.signIn,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: dark
                                          ? AppColors.primaryColor
                                          : AppColors.darkerGrey)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/constants/text_strings.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  bool _showSecondPage = false;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi ve gradyan
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_showSecondPage
                    ? ImagePaths.onboardImage
                    : ImagePaths.onboardImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: _showSecondPage
                      ? [
                          AppColors.primaryColor2.withOpacity(0.9),
                          AppColors.primaryColor2.withOpacity(0.8),
                          Colors.transparent,
                        ]
                      : [
                          AppColors.primaryColor.withOpacity(0.9),
                          AppColors.primaryColor.withOpacity(0.8),
                          Colors.transparent,
                        ],
                ),
              ),
            ),
          ),
          // İçerik
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  _showSecondPage
                      ? TTexts.onBoardingTitle2
                      : TTexts.onBoardingTitle1,
                  style: const TextStyle(
                    fontFamily: 'SignikaNegative',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _showSecondPage
                      ? TTexts.onBoardingSubTitle2
                      : TTexts.onBoardingSubTitle1,
                  style: const TextStyle(
                    fontFamily: 'SignikaNegative',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!_showSecondPage) // Sadece ilk sayfada göster
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteConstant.chooseProfileRoute);
                          },
                          child: const Text(
                            'Geç',
                            style: TextStyle(
                              fontFamily: 'SignikaNegative',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white)),
                      onPressed: () {
                        setState(() {
                          if (_showSecondPage) {
                            Navigator.pushNamed(
                                context, RouteConstant.chooseProfileRoute);
                          } else {
                            _showSecondPage = true;
                          }
                        });
                      },
                      child: SizedBox(
                        child: Container(
                          width: 100,
                          height: 20.0,
                          alignment: Alignment.center,
                          child: Text(
                              _showSecondPage
                                  ? TTexts.signIn
                                  : TTexts.tContinue,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: dark
                                          ? AppColors.primaryColor
                                          : AppColors.darkerGrey)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
