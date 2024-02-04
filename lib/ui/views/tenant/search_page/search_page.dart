// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/services/house_listing_service.dart';
import 'package:hadi_bulsana/core/utils/gap.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/ui/views/tenant/home/product_detail_page/product_details_screen.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/custom_appbar_with_button.dart';
import 'package:iconsax/iconsax.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<HouseListing> allListings = [];
  List<HouseListing> filteredListings = [];
  bool isFiltered = false;

  @override
  void initState() {
    super.initState();
    fetchAllListings();
  }

  void fetchAllListings() async {
    List<HouseListing> fetchedListings =
        await HouseListingService().getHouseListings();
    setState(() {
      allListings = fetchedListings;
      filteredListings = List.from(allListings);
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    double _minPrice = 0;
    double _maxPrice = 20000;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 20000,
                    divisions: 80, // (20000 - 0) / 250 = 80 adım
                    onChanged: (RangeValues values) {
                      setState(() {
                        _minPrice = (values.start / 250).round() * 250;
                        _maxPrice = (values.end / 250).round() * 250;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_minPrice.toInt()} ₺'), // Min fiyatı göster
                      Text('${_maxPrice.toInt()}₺'), // Max fiyatı göster
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text('UYGULA'),
                    ),
                  ),
                  /*
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('Uygula'),
                  ),
                  */
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      if (value != null && value) {
        setState(() {
          filteredListings = allListings.where((listing) {
            return listing.price >= _minPrice && listing.price <= _maxPrice;
          }).toList();
          isFiltered = true;
        });
      } else {
        setState(() {
          filteredListings = List.from(allListings);
          isFiltered = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor,
      appBar: CustomAppBarWithButton(
        title: 'Ev İlanları',
        isDark: dark,
        showBackButton: true,
        onFilterPressed: () {
          _showFilterBottomSheet(context);
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 2), //const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tüm İlanlar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: dark ? AppColors.dark : AppColors.dark),
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.01),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  /*
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Her satırda yer alacak kart sayısı
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 170, // Kartların yüksekliği
                  ),
                  */
                  itemCount:
                      isFiltered ? filteredListings.length : allListings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final HouseListing listing = isFiltered
                        ? filteredListings[index]
                        : allListings[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            houseListing: listing,
                          ), //ExploreScreen(houseListing: populars),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03, vertical: height * 0.016),
                        margin: EdgeInsets.symmetric(
                            horizontal: 1, vertical: height * 0.016),
                        decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 5.0,
                                offset: Offset(0.1, 0.1))
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: dark
                              ? AppColors.darkerGrey
                              : AppColors.whiteColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment
                                  .topRight, //Kalp ikonunun, resmin üzerindeki konumu
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: listing.photos != null &&
                                          listing.photos!.isNotEmpty
                                      ? Image(
                                          fit: BoxFit.cover,
                                          width: 85,
                                          height: 85,
                                          image:
                                              NetworkImage(listing.photos![0]),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Placeholder(
                                            color: AppColors.primaryColor,
                                            fallbackHeight: 120,
                                            fallbackWidth: 30,
                                          ),
                                        ), // Veya bir hata mesajı veya yedek bir görsel
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor
                                          .withOpacity(0.95),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.heart_fill,
                                      size: 17,
                                      color: dark
                                          ? AppColors.ratingColor
                                          : AppColors.primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // ignore: unnecessary_string_interpolations
                                  '${listing.title}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: dark
                                              ? AppColors.whiteColor
                                              : AppColors.darkerGrey),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Iconsax.location5,
                                      color: dark
                                          ? AppColors.whiteColor
                                          : AppColors.darkGrey,
                                      size: 13,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${listing.city}, ${listing.district}',
                                      style: TextStyle(
                                          color: dark
                                              ? AppColors.whiteColor
                                              : AppColors.darkGrey,
                                          fontSize: 13,
                                          fontFamily: 'SignikaNegative'),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Iconsax.money5,
                                      color: dark
                                          ? AppColors.ratingColor
                                          : AppColors.primaryColor,
                                      size: 13,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${listing.price} TL/aylık',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'SignikaNegative',
                                          color: dark
                                              ? AppColors.ratingColor
                                              : AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                //const SizedBox(height: 410.0), //KALDIRILACAK?
              ],
            ),
          ),
        ),
      ),
    );
  }
}
