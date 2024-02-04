import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/viewmodel/tenant_viewmodel/tenant_profile_viewmodel.dart';
import 'package:hadi_bulsana/ui/views/tenant/favorite/widgets/favorite_card.dart';
import 'package:hadi_bulsana/core/utils/gap.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/custom_appbar.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final searchInput = TextEditingController();
  final searchFocus = FocusNode();
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
    searchInput.dispose();
    searchFocus.dispose();
  }

  Future<void> _getUserInfo() async {
    await viewModel.getUserInfo();
    setState(() {}); // Veriler güncellendi, sayfayı tekrar çiz
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.bColor,
      appBar: CustomAppBar(
          isDark: dark, district: viewModel.district, city: viewModel.city),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favorilerim',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: dark
                        ? AppColors.whiteColor
                        : AppColors.primaryTextTextColor),
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.01),
              const FavoriteCard(
                title: "2+1 Kiralık Apart",
                loc: "Ankara",
                isHeart: false,
                path: ImagePaths.house1,
                price: 7500,
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.01),
              const FavoriteCard(
                title: "3+1 Kiralık Apart",
                loc: "Konya",
                isHeart: false,
                path: ImagePaths.house2,
                price: 7100,
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.01),
              const FavoriteCard(
                title: "1+1 Kiralık Apart",
                loc: "Konya",
                isHeart: false,
                path: ImagePaths.house3,
                price: 6500,
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.01),
              const FavoriteCard(
                title: "2+1 Kiralık Apart",
                loc: "Ankara",
                isHeart: false,
                path: ImagePaths.house4,
                price: 10000,
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.01),
              const FavoriteCard(
                title: "3+1 Kiralık Apart",
                loc: "İzmir",
                isHeart: false,
                path: ImagePaths.house5,
                price: 7300,
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.01),
              const FavoriteCard(
                title: "2+1 Kiralık Apart",
                loc: "İzmir",
                isHeart: false,
                path: ImagePaths.house6,
                price: 6900,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
