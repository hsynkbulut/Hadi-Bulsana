// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, avoid_print
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';
import 'package:hadi_bulsana/core/services/house_listing_service.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';

class UpdateHouseListViewModel with ChangeNotifier {
  final HouseListingService _houseListingService = HouseListingService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController livingRoomController = TextEditingController();
  final TextEditingController kitchenController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  List<File> selectedImages = [];
  final TextEditingController neighbourhoodController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController alleyController = TextEditingController();
  final TextEditingController apartmentNameController = TextEditingController();
  final TextEditingController buildingNoController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  bool isRented = false;

  final ValueNotifier<bool> attachMultipleImages = ValueNotifier<bool>(false);

  // ViewModel içinde compressedPhotosList'i güncellemek için bir metod
  void updateCompressedPhotosList(List<File> updatedList) {
    selectedImages = updatedList;
  }

  // Eğer bu liste dışarıdan alınacaksa, bu metodu kullanabilirsin:
  // void setCompressedPhotosList(List<String> updatedList) {
  //   compressedPhotos = updatedList;
  // }

  Future<void> updateHouseListing(
      BuildContext context, HouseListing houseListing) async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen en az bir fotoğraf seçiniz')),
      );
      return;
    }

    String newHouseID = houseListing.houseListingID!;
    String title = titleController.text;
    String description = descriptionController.text;
    int price = int.parse(priceController.text);
    String room = roomController.text;
    String livingRoom = livingRoomController.text;
    String kitchen = kitchenController.text;
    String city = cityController.text;
    String district = districtController.text;
    String neighborhood = neighbourhoodController.text;
    String street = streetController.text;
    String alley = alleyController.text;
    String apartmentName = apartmentNameController.text;
    int buildingNo = int.parse(buildingNoController.text);
    int flatNo = int.parse(flatNoController.text);
    String phoneNumber = phoneNumberController.text;
    String email = emailController.text;

    HouseListing updateHouseListing = HouseListing(
      houseListingID: newHouseID,
      title: title,
      description: description,
      price: price,
      room: room,
      livingRoom: livingRoom,
      kitchen: kitchen,
      city: city,
      district: district,
      neighborhood: neighborhood,
      street: street,
      alley: alley,
      apartmentName: apartmentName,
      buildingNo: buildingNo,
      flatNo: flatNo,
      phoneNumber: phoneNumber,
      email: email,
      photos: [], // Boş liste olarak başlatılsın
      isRented: isRented,
    );

    try {
      // Mevcut ev ilanının bilgilerini al
      HouseListing? currentHouseListing = await _houseListingService
          .getHouseListing(houseListing.houseListingID!);

      // Eski resimlerle yeni resimler arasında fark kontrolü
      List<String?> currentPhotos = currentHouseListing?.photos ?? [];
      List<String?> newPhotos =
          selectedImages.map((photo) => photo.path).toList();

      bool photosChanged = currentPhotos.length != newPhotos.length ||
          !listEquals(currentPhotos, newPhotos);

      if (photosChanged) {
        // Resimler değiştiyse, eski resimleri sil
        await _houseListingService.deletePhotos(houseListing.houseListingID!);
      }

      // Ev ilanını güncelleme
      await _houseListingService.updateHouseListing(
          updateHouseListing, selectedImages);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ev ilanı güncelleme başarılı')),
      );
      Navigator.pushNamed(context, RouteConstant.hostDashboardRoute);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ev ilanı güncelleme başarısız')),
      );
      print(e.toString());
    }
  }
}
