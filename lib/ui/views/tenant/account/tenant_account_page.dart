import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/models/tenant_model.dart';
import 'package:hadi_bulsana/core/services/tenant_service.dart';
import 'package:hadi_bulsana/core/viewmodel/tenant_viewmodel/tenant_profile_viewmodel.dart';
import 'package:hadi_bulsana/ui/views/tenant/about/about_page_tenant.dart';
import 'package:hadi_bulsana/ui/views/tenant/account/profile_page/tenant_profile_page.dart';
import 'package:iconsax/iconsax.dart';

class TenantAccountPage extends StatefulWidget {
  const TenantAccountPage({super.key});

  @override
  State<TenantAccountPage> createState() => _TenantAccountPageState();
}

class _TenantAccountPageState extends State<TenantAccountPage> {
  final TenantProfileViewModel viewModel = TenantProfileViewModel();
  bool isSigningOut = false; // Bayrak tanımlama

  String? name;
  String? surname;
  String? email;
  late Tenant tenant; // Tenants nesnesini tanımladık

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    Tenant? owner = (await TenantService().getUser())!;

    setState(() {
      tenant = owner;
      name = tenant.name;
      surname = tenant.surname;
      email = tenant.email;
    });
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
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.bColor,
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    //colorFilter: ColorFilter.srgbToLinearGamma(),
                    opacity: 0.3,
                    fit: BoxFit.cover,
                    image: AssetImage(ImagePaths.hallway)),
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            top: 130,
            right: 30,
            left: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.27,
                    height: height * 0.27,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(ImagePaths.tenantUser),
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Text(
                          ('$name $surname'),
                          style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 15,
            right: 15,
            bottom: 0,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ACCOUNT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: 35,
                        color:
                            dark ? AppColors.whiteColor : AppColors.darkerGrey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hesap',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dark
                              ? AppColors.whiteColor
                              : AppColors.darkerGrey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TenantProfilePage()),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Iconsax.user,
                          color: AppColors.error,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Profil",
                          style: TextStyle(
                            color: AppColors.darkerGrey,
                          ),
                        )),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.darkerGrey,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.help,
                        size: 35,
                        color:
                            dark ? AppColors.whiteColor : AppColors.darkerGrey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'İletişim & Yardım',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dark
                              ? AppColors.whiteColor
                              : AppColors.darkerGrey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(
                          Iconsax.message_question5,
                          color: AppColors.success,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Yardım",
                          style: TextStyle(
                            color: AppColors.darkerGrey,
                          ),
                        )),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.darkerGrey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: AppColors.warning,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Bize Ulaşın",
                          style: TextStyle(
                            color: AppColors.darkerGrey,
                          ),
                        )),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.darkerGrey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(
                          Icons.bug_report,
                          color: AppColors.info,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Sorunları bildir",
                          style: TextStyle(
                            color: AppColors.darkerGrey,
                          ),
                        )),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.darkerGrey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //Others
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.restore_page,
                        size: 35,
                        color:
                            dark ? AppColors.whiteColor : AppColors.darkerGrey,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Diğerleri',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dark
                              ? AppColors.whiteColor
                              : AppColors.darkerGrey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TenantAboutPage()),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Iconsax.information,
                          color: AppColors.warning,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Hakkımızda",
                          style: TextStyle(
                            color: AppColors.darkerGrey,
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(
                          Iconsax.security_user,
                          color: AppColors.info,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Gizlilik Politikası",
                          style: TextStyle(
                            color: AppColors.darkerGrey,
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(
                          Iconsax.paperclip_25,
                          color: AppColors.success,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Şartlar ve koşullar",
                          style: TextStyle(
                            color: AppColors.darkerGrey,
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      _signOut(); // Çıkış işlemini başlatan metot
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.logout_15,
                          color: AppColors.error,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: isSigningOut
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Çıkış Yap",
                                    style: TextStyle(
                                      color: AppColors.darkerGrey,
                                    ),
                                  )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'version 1.0.0',
                        style: TextStyle(
                          fontSize: 13,
                          color: dark ? AppColors.bColor : AppColors.dark,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  )
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
