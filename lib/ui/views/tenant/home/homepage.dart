// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/services/house_listing_service.dart';
import 'package:hadi_bulsana/core/viewmodel/tenant_viewmodel/tenant_profile_viewmodel.dart';
import 'package:hadi_bulsana/ui/views/tenant/home/explore/explore_card.dart';
import 'package:hadi_bulsana/core/utils/gap.dart';
import 'package:hadi_bulsana/core/utils/row_title_home.dart';
import 'package:hadi_bulsana/ui/views/tenant/search_page/search_page.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/custom_appbar.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/custom_carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchInput = TextEditingController();
  final searchFocus = FocusNode();
  final TenantProfileViewModel viewModel = TenantProfileViewModel();
  late StreamSubscription<bool> _updateSubscription;

  @override
  void initState() {
    super.initState();
    _getUserInfo();

    fetchAllListings();

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

  //-------------------------------------------------------------------------------
  // double _minPrice = 0;
  // double _maxPrice = 20000;

  List<HouseListing> allListings = [];
  List<HouseListing> filteredListings = [];
  bool isFiltered = false;

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
    String selectedCity = '';
    String selectedDistrict = '';

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Şehir',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      selectedCity = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'İlçe',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      selectedDistrict = value;
                    },
                  ),
                  const SizedBox(height: 15),
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
                      Text('${_minPrice.toInt()}₺'), // Min fiyatı göster
                      Text('${_maxPrice.toInt()}₺'), // Max fiyatı göster
                    ],
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          {
                            'city': selectedCity,
                            'district': selectedDistrict,
                            'minPrice': _minPrice,
                            'maxPrice': _maxPrice,
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text('UYGULA'),
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      if (value != null && value is Map<String, dynamic>) {
        setState(() {
          filteredListings = allListings.where((listing) {
            bool cityMatch =
                value['city'].isEmpty || value['city'] == listing.city;
            bool districtMatch = value['district'].isEmpty ||
                value['district'] == listing.district;
            bool priceMatch = listing.price >= value['minPrice'] &&
                listing.price <= value['maxPrice'];

            return cityMatch && districtMatch && priceMatch;
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

    return WillPopScope(
      onWillPop: () async {
        // Geri tuşuna basıldığında ne olacağını burada belirleyebilirsin.
        // Örneğin, hiçbir şey yapmamak için 'return false' dönebilirsin.
        return false; // Geri tuşunun işlevsiz olduğunu belirtiyoruz.
      },
      child: Scaffold(
        backgroundColor: dark ? AppColors.dark : AppColors.bColor,
        appBar: CustomAppBar(
            isDark: dark, district: viewModel.district, city: viewModel.city),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.045),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Hoşgeldin",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: dark
                                  ? AppColors.whiteColor
                                  : AppColors.darkerGrey.withOpacity(0.8)),
                    ),
                    Gap(isWidth: true, isHeight: false, width: width * 0.03),
                    Text(
                      viewModel.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary),
                    ),
                  ],
                ),
                //const SizedBox(height: 15),
                Gap(isWidth: false, isHeight: true, height: height * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: Theme.of(context)
                                      .inputDecorationTheme
                                      .enabledBorder!
                                      .copyWith(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.black
                                                .withOpacity(0.2)),
                                      ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Theme.of(context)
                                        .iconTheme
                                        .copyWith(
                                            color: dark
                                                ? AppColors.black
                                                : AppColors.primaryColor)
                                        .color,
                                  ),
                                  hintText: 'Burada ara',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    color:
                                        AppColors.textPrimary.withOpacity(0.6),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //const SizedBox(width: 10),
                    Gap(isWidth: true, isHeight: false, width: width * 0.029),
                    GestureDetector(
                      onTap: () {
                        _showFilterBottomSheet(context);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.black.withOpacity(0.2)),
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.list,
                            size: 18.0,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.03),
                /*
                // Popüler Olanlar
                RowTitleHome(
                  title: "Popüler Olanlar",
                  subtitle: "Hepsi",
                  onPress: () {},
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.02),
                */
                //const TopPopularCarousel(),
                const CustomCarouselSlider(
                  images: [
                    "https://cdn.pixabay.com/photo/2023/12/04/01/30/building-8428549_1280.jpg",
                    "https://cdn.pixabay.com/photo/2017/06/13/22/42/kitchen-2400367_1280.jpg",
                    "https://cdn.pixabay.com/photo/2017/04/13/17/48/floor-2228277_1280.jpg"
                  ],
                  captions: [
                    "Hoş Geldiniz! Hadi Bulsana'yla Şehrinizdeki En İyi Apartları Keşfedin.",
                    "Konforlu ve Uygun Fiyatlı Apartlar Burada! Aradığınızı Hemen Bulun.",
                    "Güvenli ve Hızlı Apart Bulma Deneyimi! Şimdi Keşfedin ve Kiralayın."
                  ],
                ),

                //Yakınlardaki Yerler
                Gap(isWidth: false, isHeight: true, height: height * 0.03),
                RowTitleHome(
                  title: "Yakınlardaki Yerler", //"Yakınlardaki Yerler",
                  subtitle: "Hepsi",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()),
                    );
                  },
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.02),
                ExploreCard(
                    houseListings: isFiltered ? filteredListings : allListings),
                Gap(isWidth: false, isHeight: true, height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
