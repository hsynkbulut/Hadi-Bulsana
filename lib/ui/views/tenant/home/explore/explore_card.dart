// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/utils/gap.dart';
import 'package:hadi_bulsana/ui/views/tenant/home/product_detail_page/product_details_screen.dart';
import 'package:iconsax/iconsax.dart';

class ExploreCard extends StatefulWidget {
  final List<HouseListing> houseListings;
  const ExploreCard({Key? key, required this.houseListings}) : super(key: key);

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  List<HouseListing> _houseListings = [];

  @override
  void didUpdateWidget(covariant ExploreCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.houseListings != widget.houseListings) {
      setState(() {
        _houseListings = List.from(widget.houseListings);
      });
    }
  }

  Future<void> getHouseListings() async {
    try {
      //List<HouseListing> houseListings = await HouseListingService().getQuestions();
      setState(() {
        // _houseListings = houseListings;
        _houseListings = widget.houseListings;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Her satırda yer alacak kart sayısı
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 270, // Kartların yüksekliği
      ),
      itemCount: _houseListings.length,
      itemBuilder: (_, index) {
        HouseListing populars = _houseListings[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(
                houseListing: populars,
              ), //ExploreScreen(houseListing: populars),
            ),
          ),
          child: Container(
            //margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: dark ? AppColors.darkerGrey : AppColors.whiteColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child:
                          populars.photos != null && populars.photos!.isNotEmpty
                              ? Image(
                                  fit: BoxFit.cover,
                                  height: 160,
                                  image: NetworkImage(populars.photos![0]),
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
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Iconsax.heart,
                            size: 18,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Gap(
                  isWidth: false,
                  isHeight: true,
                  height: height * 0.01,
                ),
                Text(
                  '${populars.room}+${populars.livingRoom} Kiralık Apart',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color:
                            dark ? AppColors.whiteColor : AppColors.darkerGrey,
                      ),
                ),
                Gap(
                  isWidth: false,
                  isHeight: true,
                  height: height * 0.005,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: dark ? AppColors.whiteColor : AppColors.darkGrey,
                    ),
                    Text(
                      '${populars.city}, ${populars.district}',
                      style: TextStyle(
                        color: dark ? AppColors.whiteColor : AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.01),
                Text(
                  '${populars.price} TL/aylık',
                  style: TextStyle(
                    color:
                        dark ? AppColors.ratingColor : AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
