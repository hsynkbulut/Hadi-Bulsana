import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';
import 'package:hadi_bulsana/core/viewmodel/homeowner_viewmodel/host_profile_viewmodel.dart';
import 'package:hadi_bulsana/ui/views/homeowner/home/widgets/long_module_card.dart';
import 'package:hadi_bulsana/ui/views/homeowner/home/widgets/short_bottom_module_card.dart';
import 'package:hadi_bulsana/ui/views/homeowner/home/widgets/short_top_module_card.dart';
import 'package:iconsax/iconsax.dart';

class HostDashboard extends StatefulWidget {
  const HostDashboard({Key? key}) : super(key: key);

  @override
  State<HostDashboard> createState() => _HostDashboardState();
}

class _HostDashboardState extends State<HostDashboard> {
  /*
  String? profilePhotoUrl;
  String? name;
  String? surname;
  String? email;
  bool isImageFullScreen = false;
  late HomeOwner homeOwner;
  */

  final HostProfileViewModel viewModel = HostProfileViewModel();
  bool isSigningOut = false;
  late StreamSubscription<bool> _updateSubscription;

  @override
  void initState() {
    super.initState();
    //getUserInfo();
    _getUserInfo();

    // Stream'i dinle
    _updateSubscription = viewModel.updateStream.listen((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Aboneliği iptal et ve StreamController'ı temizle
    _updateSubscription.cancel();
    viewModel.dispose();
  }

  Future<void> _getUserInfo() async {
    await viewModel.getUserInfo();
    setState(() {}); // Veriler güncellendi, sayfayı tekrar çiz
  }

  /*
  Future<void> getUserInfo() async {
    HomeOwner? owner = (await HomeOwnerService().getUser())!;

    setState(() {
      homeOwner = owner;
      profilePhotoUrl = homeOwner.profilePhoto;
      name = homeOwner.name;
      surname = homeOwner.surname;
      email = homeOwner.email;
    });
  }
  */

  void _signOut() async {
    setState(() {
      isSigningOut = true; // Çıkış işlemi başladığında bayrağı true yap
    });

    // İşlemi gerçekleştir
    await viewModel.signOutAccount(context);

    setState(() {
      isSigningOut = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);

    return WillPopScope(
      onWillPop: () async {
        // Geri tuşuna basıldığında ne olacağını burada belirleyebilirsin.
        // Örneğin, hiçbir şey yapmamak için 'return false' dönebilirsin.
        return false; // Geri tuşunun işlevsiz olduğunu belirtiyoruz.
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                height: height / 4,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor2,
                  image: DecorationImage(
                      image: AssetImage(ImagePaths.bgGradientHost),
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover),
                ),
                child: SafeArea(
                  child: Container(
                    height: 100,
                    width: 200,
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.06, vertical: height * 0.03),
                    padding: EdgeInsets.only(bottom: height * 0.04),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: viewModel.profilePhotoUrl != null
                              ? NetworkImage(viewModel.profilePhotoUrl!)
                              : const AssetImage(ImagePaths.tenantMan)
                                  as ImageProvider<Object>?,
                          backgroundColor: AppColors.whiteColor,
                        ),
                        SizedBox(width: width * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            viewModel.name != null && viewModel.surname != null
                                ? Text(
                                    '${viewModel.name ?? ''} ${viewModel.surname ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.whiteColor,
                                    ),
                                  )
                                : const CircularProgressIndicator(
                                    color: AppColors.ratingColor,
                                    //backgroundColor: AppColors.whiteColor,
                                    //value: 0.50,
                                  ),
                            const SizedBox(height: 1),
                            const Text(
                              'Ev Sahibi',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.06, vertical: height * 0.03),
              height: height - (height / 5),
              width: width,
              decoration: BoxDecoration(
                  color: AppColors.bColor,
                  borderRadius: BorderRadius.circular(34)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            LongModuleCard(
                              background: AppColors.primaryColor,
                              title: 'İlan Ekle',
                              icon: Iconsax.add_square5,
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouteConstant.addHouseListingRoute);
                              },
                            ),
                            ShortBottomModuleCard(
                              background: AppColors.success,
                              title: 'İlanlarını Listele',
                              icon: Iconsax.category_2,
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouteConstant.getHouseListingRoute);
                              },
                            ),
                            ShortTopModuleCard(
                              background: AppColors.ratingColor,
                              title: 'Hesabım',
                              icon: Iconsax.profile_tick,
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouteConstant.homeOwnerProfileRoute);
                              },
                            ),
                            LongModuleCard(
                              background: AppColors.primaryColor,
                              title: 'Kiralanmış İlanlar',
                              icon: Iconsax.add_square5,
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouteConstant.getRentedHouseListingRoute);
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ShortTopModuleCard(
                              background: AppColors.primary,
                              title: 'İlan Güncelle',
                              icon: Iconsax.refresh,
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouteConstant.updateHouseListingRoute);
                              },
                            ),
                            LongModuleCard(
                              background: AppColors.primaryColor2,
                              title: 'İlan Sil',
                              icon: Iconsax.trash,
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouteConstant.deleteHouseListingRoute);
                              },
                            ),
                            ShortBottomModuleCard(
                              background: AppColors.darkerGrey,
                              title: 'Uygulama Hakkında',
                              icon: Iconsax.information5,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteConstant.homeOwnerAboutRoute);
                              },
                            ),
                            ShortTopModuleCard(
                              background: AppColors.warning,
                              title: 'Çıkış Yap',
                              icon: Iconsax.logout,
                              onTap: () {
                                _signOut(); // Çıkış işlemini başlatan metot
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
