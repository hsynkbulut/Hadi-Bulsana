import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hadi_bulsana/common/constants/image_paths.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hadi_bulsana/core/models/homeowner_model.dart';
import 'package:hadi_bulsana/core/services/authentication/auth_service_homeowner.dart';
import 'package:hadi_bulsana/core/services/homeowner_service.dart';
import 'package:photo_view/photo_view.dart';

class HostProfileViewModel {
  final AuthServiceHomeOwner authService = AuthServiceHomeOwner();
  final HomeOwnerService homeOwnerService = HomeOwnerService();
  late HomeOwner homeOwner;

  late StreamController<bool> _updateController;

  HostProfileViewModel() {
    _updateController = StreamController<bool>.broadcast();
  }

  // Veri güncellendiğinde stream'e haber veren metod
  Stream<bool> get updateStream => _updateController.stream;

  void notifyUIUpdate() {
    if (!_updateController.isClosed) {
      _updateController.add(true);
    }
  }

  // Diğer metodlar

  // dispose metoduyla StreamController'ı temizle
  void dispose() {
    _updateController.close();
  }

  String? profilePhotoUrl;
  String? name;
  String? surname;
  String? email;
  String? phoneNumber;
  bool isImageFullScreen = false;

  Future<void> getUserInfo() async {
    homeOwner = (await homeOwnerService.getUser())!;

    profilePhotoUrl = homeOwner.profilePhoto;
    name = homeOwner.name;
    surname = homeOwner.surname;
    email = homeOwner.email;
    phoneNumber = homeOwner.phoneNumber;

    notifyUIUpdate();
  }

  Future<void> updateProfilePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      HomeOwner updatedHomeOwner = HomeOwner(
        //homeOwnerID: homeOwner.userID,
        userID: homeOwner.userID,
        name: homeOwner.name,
        surname: homeOwner.surname,
        email: homeOwner.email,
        password: homeOwner.password,
        profilePhoto: homeOwner.profilePhoto,
        phoneNumber: homeOwner.phoneNumber,
      );

      await homeOwnerService
          .updateUser(updatedHomeOwner, File(image.path))
          .then((_) {
        profilePhotoUrl = updatedHomeOwner.profilePhoto;
        notifyUIUpdate();
      }).catchError((error) {
        // Hata durumuyla ilgili işlemler
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Hata'),
              content: const Text(
                  'Profil fotoğrafı değiştirilirken bir hata oluştu.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Tamam'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    // Dialog gösterme işlemleri
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hesap Silme Onayı'),
          content: const Text(
              'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'ı kapat
              },
            ),
            TextButton(
              child: const Text('Evet'),
              onPressed: () async {
                Navigator.pushNamed(context, RouteConstant.tabbarHostAuthRoute);
                await deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAccount() async {
    await authService.deleteUser();
  }

  Future<void> signOutAccount(BuildContext context) async {
    try {
      await authService.signOutUser(); // Çıkış yapma işlemi
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, RouteConstant.onBoardScreenRoute);
      Fluttertoast.showToast(
          msg: "Çıkış yapıldı", toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Çıkış yapılamadı: $e", toastLength: Toast.LENGTH_LONG);
    }
  }

  void updateUserInfo(HomeOwner updatedHomeOwner) {
    homeOwner = updatedHomeOwner;
    profilePhotoUrl = updatedHomeOwner.profilePhoto;
    name = updatedHomeOwner.name;
    surname = updatedHomeOwner.surname;
    email = updatedHomeOwner.email;

    notifyUIUpdate();
  }

  void showFullScreenImage(BuildContext context) {
    // Tam ekran resim gösterme işlemleri
    isImageFullScreen = true;
    notifyUIUpdate();

    showDialog(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            isImageFullScreen = false;
            notifyUIUpdate();
            Navigator.of(context).pop(); // Dialog'ı kapat
          },
          child: PhotoView(
            imageProvider: profilePhotoUrl != null
                ? NetworkImage(profilePhotoUrl!)
                : const AssetImage(ImagePaths.tenantMan)
                    as ImageProvider<Object>?,
            backgroundDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}
