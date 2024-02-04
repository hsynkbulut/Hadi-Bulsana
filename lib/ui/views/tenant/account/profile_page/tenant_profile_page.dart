import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/common/styles/spacing_styles.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/core/viewmodel/tenant_viewmodel/tenant_profile_viewmodel.dart';
import 'package:hadi_bulsana/ui/views/tenant/edit_profile/tenant_edit_profile_page.dart';
import 'package:hadi_bulsana/ui/views/tenant/account/profile_page/widgets/tenant_profile_item.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/tenant_appbar.dart';
import 'package:iconsax/iconsax.dart';

class TenantProfilePage extends StatefulWidget {
  const TenantProfilePage({super.key});

  @override
  State<TenantProfilePage> createState() => _TenantProfilePageState();
}

class _TenantProfilePageState extends State<TenantProfilePage> {
  final TenantProfileViewModel viewModel = TenantProfileViewModel();
  late StreamSubscription<bool> _updateSubscription;

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

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor,
      appBar: TenantAppBar(
        showBackButton: true,
        title: 'Hesabım',
        isDark: dark,
      ),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight, //const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                //const SizedBox(height: 20),
                SizedBox(height: height * 0.04),
                TenantProfileItem(
                  title: 'Adı Soyadı',
                  subtitle: ('${viewModel.name} ${viewModel.surname}') ?? '',
                  iconData: Iconsax.user,
                ),
                //const SizedBox(height: 20),
                SizedBox(height: height * 0.03),
                TenantProfileItem(
                  title: 'Email',
                  subtitle: viewModel.email ?? '',
                  iconData: Iconsax.direct,
                ),
                //const SizedBox(height: 20),
                SizedBox(height: height * 0.03),
                TenantProfileItem(
                  title: 'Telefon numarası',
                  subtitle: viewModel.phoneNumber ?? '',
                  iconData: Iconsax.call,
                ),
                //const SizedBox(height: 30),
                SizedBox(height: height * 0.03),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final updatedUser = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TenantEditProfilePage(tenant: viewModel.tenant!),
                        ),
                      );

                      if (updatedUser != null) {
                        viewModel.updateUserInfo(updatedUser);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          dark ? AppColors.black : AppColors.primaryColor,
                      foregroundColor:
                          dark ? AppColors.whiteColor : AppColors.whiteColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('DÜZENLE'),
                  ),
                ),
                //const SizedBox(height: 15),
                SizedBox(height: height * 0.02),
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
                SizedBox(height: height * 0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
