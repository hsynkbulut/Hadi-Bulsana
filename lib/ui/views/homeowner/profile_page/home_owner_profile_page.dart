import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/common/styles/spacing_styles.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/core/viewmodel/homeowner_viewmodel/host_profile_viewmodel.dart';
import 'package:hadi_bulsana/ui/views/homeowner/edit_profile/host_edit_profile_page.dart';
import 'package:hadi_bulsana/ui/views/homeowner/profile_page/widgets/host_profile_item.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/homeowner_appbar.dart';
import 'package:iconsax/iconsax.dart';

class HomeOwnerProfilePage extends StatefulWidget {
  const HomeOwnerProfilePage({super.key});

  @override
  State<HomeOwnerProfilePage> createState() => _HomeOwnerProfilePageState();
}

class _HomeOwnerProfilePageState extends State<HomeOwnerProfilePage> {
  final HostProfileViewModel viewModel = HostProfileViewModel();
  late StreamSubscription<bool> _updateSubscription;
  bool isSigningOut = false; // Bayrak tanımlama

  @override
  void initState() {
    super.initState();
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
    final dark = THelperFunctions.isDarkMode(context);
    //final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor2,
      appBar: HomeOwnerAppBar(
        showBackButton: true,
        title: 'Hesabım',
        isDark: dark,
      ),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                //const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    viewModel.showFullScreenImage(context);
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundImage: viewModel.profilePhotoUrl != null
                            ? NetworkImage(viewModel.profilePhotoUrl!)
                            : const AssetImage(ImagePaths.homeOwner)
                                as ImageProvider<Object>?,
                        backgroundColor: AppColors.dark,
                      ),
                      Positioned(
                        bottom: 2,
                        left: 75,
                        right: 0,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: dark
                                ? AppColors.whiteColor
                                : AppColors.primaryColor2,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                viewModel.updateProfilePhoto(context).then((_) {
                                  viewModel
                                      .getUserInfo(); // Profil bilgilerini yeniden getir
                                });
                              },
                              icon: Icon(
                                Iconsax.camera,
                                color: dark
                                    ? AppColors.dark
                                    : AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                HostProfileItem(
                  title: 'Adı Soyadı',
                  subtitle: ('${viewModel.name} ${viewModel.surname}') ?? '',
                  iconData: Iconsax.user,
                ),
                const SizedBox(height: 10),
                HostProfileItem(
                  title: 'Email',
                  subtitle: viewModel.email ?? '',
                  iconData: Iconsax.direct,
                ),
                const SizedBox(height: 10),
                HostProfileItem(
                  title: 'Telefon numarası',
                  subtitle: viewModel.phoneNumber ?? '',
                  iconData: Iconsax.call,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final updatedUser = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HostEditProfilePage(
                              homeOwner: viewModel.homeOwner),
                        ),
                      );

                      if (updatedUser != null) {
                        viewModel.updateUserInfo(updatedUser);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          dark ? AppColors.black : AppColors.primaryColor2,
                      foregroundColor:
                          dark ? AppColors.whiteColor : AppColors.whiteColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('DÜZENLE'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.showDeleteConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          dark ? AppColors.warning : AppColors.warning,
                      foregroundColor:
                          dark ? AppColors.black : AppColors.whiteColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('HESABIMI SİL'),
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _signOut(); // Çıkış işlemini başlatan metot
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dark ? AppColors.error : AppColors.dark,
                      foregroundColor:
                          dark ? AppColors.whiteColor : AppColors.whiteColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: isSigningOut
                        ? const CircularProgressIndicator() // İşlem sırasında gösterilecek widget
                        : const Text('ÇIKIŞ YAP'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
