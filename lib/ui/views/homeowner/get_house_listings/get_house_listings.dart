// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/common/constants/colors.dart';
import 'package:hadi_bulsana/common/helpers/helpers_functions.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/services/house_listing_service.dart';
import 'package:hadi_bulsana/core/utils/themes/background_gradient.dart';
import 'package:hadi_bulsana/ui/widgets/homeowner_widgets/homeowner_appbar.dart';

class GetHouseListingScreen extends StatefulWidget {
  const GetHouseListingScreen({Key? key}) : super(key: key);

  @override
  _GetHouseListingScreenState createState() => _GetHouseListingScreenState();
}

class _GetHouseListingScreenState extends State<GetHouseListingScreen> {
  List<HouseListing> _houseListings = [];

  @override
  void initState() {
    super.initState();
    getHouseListings();
  }

  Future<void> getHouseListings() async {
    try {
      List<HouseListing> houseListings =
          await HouseListingService().getUserHouseListings();
      setState(() {
        _houseListings = houseListings;
      });
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
        title: 'İlanlarım',
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
              return Card(
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _houseListings[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                // ignore: unnecessary_string_interpolations
                                Text('${_houseListings[index].description}'),
                                Text(
                                    '${_houseListings[index].room} Oda, ${_houseListings[index].livingRoom} Salon, ${_houseListings[index].kitchen} Mutfak'),
                                SizedBox(height: 8),
                                Text(
                                    '${_houseListings[index].neighborhood} Mah. ${_houseListings[index].street} Cad. ${_houseListings[index].alley} Sk. ${_houseListings[index].apartmentName} Sitesi/Apartı ${_houseListings[index].buildingNo}/${_houseListings[index].flatNo} ${_houseListings[index].district}, ${_houseListings[index].city}'),
                                SizedBox(height: 8),
                                Text(
                                    '${_houseListings[index].email} - ${_houseListings[index].phoneNumber}'),
                                SizedBox(height: 8),
                                Text('${_houseListings[index].price}₺',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                SizedBox(height: 16),
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        _houseListings[index].photos!.length,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          _houseListings[index].photos![i],
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Tamam'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
