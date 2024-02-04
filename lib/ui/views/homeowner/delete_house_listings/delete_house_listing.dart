// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/services/house_listing_service.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/homeowner_appbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';

class DeleteHouseListingScreen extends StatefulWidget {
  const DeleteHouseListingScreen({Key? key}) : super(key: key);

  @override
  _DeleteHouseListingScreenState createState() =>
      _DeleteHouseListingScreenState();
}

class _DeleteHouseListingScreenState extends State<DeleteHouseListingScreen> {
  List<HouseListing> _houseListings = [];
  final HouseListingService _houseListingService = HouseListingService();

  @override
  void initState() {
    super.initState();
    getHouseListings();
  }

  Future<void> getHouseListings() async {
    try {
      List<HouseListing> houseListings =
          await _houseListingService.getUserHouseListings();
      setState(() {
        _houseListings = houseListings;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteHouseListing(int index) async {
    try {
      HouseListing deletedHouseListing = _houseListings[index];

      await _houseListingService
          .deleteHouseListing(deletedHouseListing.houseListingID!);

      await _houseListingService
          .deletePhotos(deletedHouseListing.houseListingID!);

      setState(() {
        _houseListings.removeAt(index);
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('İlan silindi.'),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryColor2,
      appBar: HomeOwnerAppBar(
        showBackButton: true,
        title: 'İlan Sil',
        isDark: dark,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient2(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          child: ListView.builder(
            itemCount: _houseListings.length,
            itemExtent: 120, // sabit yükseklik
            itemBuilder: (context, index) {
              return Slidable(
                startActionPane:
                    ActionPane(motion: const StretchMotion(), children: [
                  SlidableAction(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      backgroundColor: AppColors.success,
                      icon: Iconsax.information,
                      label: 'Detay',
                      onPressed: (context) => {}),
                ]),
                endActionPane:
                    ActionPane(motion: const BehindMotion(), children: [
                  SlidableAction(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      backgroundColor: AppColors.error,
                      icon: Iconsax.trash,
                      label: 'Delete',
                      onPressed: (context) => {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('İlanı Sil'),
                                  content: const Text(
                                      'Bu ilanı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Vazgeç'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteHouseListing(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Sil'),
                                    ),
                                  ],
                                );
                              },
                            ),
                          })
                ]),
                child: Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.02, vertical: height * 0.014),
                  child: ListTile(
                    dense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: Image.network(
                      _houseListings[index].photos![0],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      _houseListings[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        "${_houseListings[index].city}, ${_houseListings[index].district}"),
                    trailing: Text(
                      '${_houseListings[index].price}₺',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
