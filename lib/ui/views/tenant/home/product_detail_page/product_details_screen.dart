import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/common/styles/spacing_styles.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/services/house_listing_service.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/ui/views/tenant/home/product_detail_page/widgets/explore_carousel_slider.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/tenant_appbar.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailsScreen extends StatefulWidget {
  final HouseListing houseListing;

  const ProductDetailsScreen({super.key, required this.houseListing});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  NumberFormat formatter = NumberFormat();
  bool isRented = false;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor,
      appBar: TenantAppBar(
        showBackButton: true,
        title: 'İlan Detayı',
        isDark: dark,
      ),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExploreCarouselSlider(
                  images: widget.houseListing.photos!,
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //adding and Rating function
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.houseListing.city}, ${widget.houseListing.district}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Iconsax.heart,
                            size: 18,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.houseListing.room}+${widget.houseListing.livingRoom} Kiralık Apart',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.houseListing.price} TL/aylık',
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Açıklama',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      widget.houseListing.description,
                      style: const TextStyle(
                          fontSize: 13.0, color: Colors.black45),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.bed,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                '${widget.houseListing.room} Oda',
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.restroom,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                '${widget.houseListing.livingRoom} Salon',
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.kitchenSet,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                '${widget.houseListing.kitchen} Mutfak',
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    Container(
                      height: height * 0.23,
                      //width: width * 0.9,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.025),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.darkGrey,
                                    //borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Image.asset(
                                    ImagePaths.homeOwner,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: width * 0.023),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'İlan Sahibi',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Telefon no: ',
                                          style: TextStyle(
                                              color: AppColors.darkerGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          widget.houseListing.phoneNumber,
                                          style: const TextStyle(
                                              color: AppColors.darkerGrey,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'E-mail: ',
                                          style: TextStyle(
                                              color: AppColors.darkerGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          widget.houseListing.email,
                                          style: const TextStyle(
                                              color: AppColors.darkerGrey,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Mevcut isRented durumunu al
                                  bool currentStatus =
                                      widget.houseListing.isRented ?? false;

                                  // isRented durumunu tersine çevir ve veritabanında güncelle
                                  await HouseListingService()
                                      .toggleRentalStatus(
                                          widget.houseListing.houseListingID!,
                                          currentStatus);

                                  // setState kullanarak yeni durumu ekrana yansıt
                                  setState(() {
                                    widget.houseListing.isRented =
                                        !currentStatus;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  widget.houseListing.isRented ?? false
                                      ? 'Kiralandı'
                                      : 'Kirala',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
