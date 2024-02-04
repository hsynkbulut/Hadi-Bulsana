// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/services/house_listing_service.dart';

class GetRentedHouseViewModel {
  late List<HouseListing> _houseListings = [];
  final HouseListingService _houseListingService = HouseListingService();

  List<HouseListing> get houseListings => _houseListings;

  late StreamController<bool> _updateController;

  GetRentedHouseViewModel() {
    _updateController = StreamController<bool>.broadcast();
  }

  // Veri güncellendiğinde stream'e haber veren metod
  Stream<bool> get updateStream => _updateController.stream;

  void notifyUIUpdate() {
    if (!_updateController.isClosed) {
      _updateController.add(true);
    }
  }

  // dispose metoduyla StreamController'ı temizle
  void dispose() {
    _updateController.close();
  }

  Future<void> getRentedHouseListings() async {
    try {
      List<HouseListing> houseListings =
          await _houseListingService.getRentedHouseListings();
      _houseListings = houseListings;

      notifyUIUpdate();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteHouseListing(BuildContext context, int index) async {
    try {
      HouseListing deletedHouseListing = _houseListings[index];

      await _houseListingService
          .deleteHouseListing(deletedHouseListing.houseListingID!);

      await _houseListingService
          .deletePhotos(deletedHouseListing.houseListingID!);

      _houseListings.removeAt(index);
      //notifyListeners();
      notifyUIUpdate();

      // Show a SnackBar using a callback passed from the UI
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
}
