// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/core/viewmodel/homeowner_viewmodel/get_rented_house_viewmodel.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/homeowner_appbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';

class GetRentedHouseListingScreen extends StatefulWidget {
  const GetRentedHouseListingScreen({Key? key}) : super(key: key);

  @override
  _GetRentedHouseListingScreenState createState() =>
      _GetRentedHouseListingScreenState();
}

class _GetRentedHouseListingScreenState
    extends State<GetRentedHouseListingScreen> {
  final GetRentedHouseViewModel viewModel = GetRentedHouseViewModel();
  late StreamSubscription<bool> _updateSubscription;

  @override
  void initState() {
    super.initState();
    _getRentedHouseListings();

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

  Future<void> _getRentedHouseListings() async {
    await viewModel.getRentedHouseListings();
    setState(() {}); // Veriler güncellendi, sayfayı tekrar çiz
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
        title: 'Kiralanmış İlanlar',
        isDark: dark,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient2(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          child: ListView.builder(
            itemCount: viewModel.houseListings.length,
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
                                        viewModel.deleteHouseListing(
                                            context, index);
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
                      viewModel.houseListings[index].photos![0],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      viewModel.houseListings[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        "${viewModel.houseListings[index].city}, ${viewModel.houseListings[index].district}"),
                    trailing: Text(
                      '${viewModel.houseListings[index].price}₺',
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
