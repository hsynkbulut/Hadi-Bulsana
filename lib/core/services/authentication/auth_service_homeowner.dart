// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hadi_bulsana/common/helpers/custom_error_message.dart';
import 'package:hadi_bulsana/core/models/homeowner_model.dart';
import 'package:hadi_bulsana/core/services/authentication/authentication_service.dart';
import 'package:hadi_bulsana/core/services/homeowner_service.dart';
import 'package:hadi_bulsana/core/services/house_listing_service.dart';

class AuthServiceHomeOwner extends AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final HomeOwnerService _homeOwnerService = HomeOwnerService();
  final HouseListingService _houseListingService = HouseListingService();

  // Ev sahibinin uygulamaya kaydolmasını sağlar
  @override
  Future<String?> signUpUser({
    required String name,
    required String surname,
    required String email,
    required String phoneNumber,
    required String password,
    File? profilePhoto,
    String? city,
    String? district,
  }) async {
    try {
      // email, username ve password değerlerini boş olup olmadıklarını kontrol et
      if (name.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen adınızı giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (surname.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen soyadınızı giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen e-mail adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (phoneNumber.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen telefon numaranızı giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (password.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen şifrenizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      // Ev sahibini Firebase Auth ile kaydet
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Oluşturulan Ev sahibini veritabanına kaydet
      HomeOwner homeOwner = HomeOwner(
        //homeOwnerID: userCredential.user!.uid,
        userID: userCredential.user!.uid,
        name: name,
        surname: surname,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );
      await _homeOwnerService.createUser(homeOwner, profilePhoto);

      // Başarılı mesajı göster
      Fluttertoast.showToast(
        msg: "Kayıt işlemi başarılı",
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      // Hata mesajını CustomErrorMessage sınıfından al
      //String errorMessage = CustomErrorMessage.getRegisterErrorMessage(e.code);
      Fluttertoast.showToast(msg: "Uyarı: $e", toastLength: Toast.LENGTH_LONG);
      print("Uyarı mesajı: $e");
    }
    return null;
  }

  // Ev sahibinin uygulamaya giriş yapmasını sağlar
  @override
  Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen email adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (password.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen şifrenizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
        msg: "Giriş işlemi başarılı",
        toastLength: Toast.LENGTH_SHORT,
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      String errorMessage = CustomErrorMessage.getLoginErrorMessage(e.code);
      Fluttertoast.showToast(
          msg: "Uyarı: $errorMessage", toastLength: Toast.LENGTH_LONG);
    }
    return null;
  }

  // Ev sahibinin uygulamadan çıkış yapmasını sağlar
  @override
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Ev sahibinin şifresini sıfırlama isteği gönderir
  @override
  Future<void> resetPasswordUser(BuildContext context, String email) async {
    final navigator = Navigator.of(context);
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen e-posta adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return;
      }
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "E-posta adresinize bir şifre sıfırlama isteği gönderildi",
        toastLength: Toast.LENGTH_LONG,
      );
      navigator.pop();
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          CustomErrorMessage.getForgotPasswordErrorMessage(e.code);
      Fluttertoast.showToast(
          msg: "Uyarı: $errorMessage", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      String uid = _auth.currentUser!.uid;

      // Ev sahibinin ilanlarını sil
      await _houseListingService.deleteHouseListingsOfUser(uid);

      // Firebase Authentication'dan kullanıcıyı sil
      await _auth.currentUser!.delete();

      // Kullanıcıyı Firestore'dan sil
      await _homeOwnerService.deleteUser(uid);

      // Başarılı mesajı göster
      Fluttertoast.showToast(
        msg: "Kullanıcı hesabı başarıyla silindi.",
        toastLength: Toast.LENGTH_LONG,
      );

      // Çıkış yap ve profil sayfasından yönlendir
      await signOutUser();
    } catch (e) {
      print("HATA: ${e.toString()}");
      // Hata mesajını göster
      Fluttertoast.showToast(
        msg: "Kullanıcı hesabını silerken bir hata oluştu.",
        toastLength: Toast.LENGTH_LONG,
      );

      return;
    }
  }

  @override
  Future<void> updateUserInformation(
      {required String newName,
      required String newSurname,
      required String newEmail,
      required String newPhoneNumber,
      required String newPassword,
      String? newCity,
      String? newDistrict,
      File? profilePhoto}) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Kullanıcının Firebase Authentication e-posta ve şifresini güncelle
        await currentUser.updateEmail(newEmail);
        await currentUser.updatePassword(newPassword);
        //await currentUser.updatePhoneNumber(newPhoneNumber as PhoneAuthCredential);
        //await currentUser.updatePhotoURL(profilePhoto.toString());

        // Firestore'dan kullanıcının mevcut bilgilerini al
        HomeOwner? homeOwner = await _homeOwnerService.getUser();

        if (homeOwner != null) {
          // Kullanıcının Firestore Database bilgilerini güncelle
          homeOwner.name = newName;
          homeOwner.surname = newSurname;
          homeOwner.email = newEmail;
          homeOwner.phoneNumber = newPhoneNumber;
          homeOwner.password = newPassword;

          await _homeOwnerService.updateUser(homeOwner, profilePhoto);
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          CustomErrorMessage.getUpdateUserErrorMessage(e.code);
      Fluttertoast.showToast(
          msg: "Uyarı: $errorMessage", toastLength: Toast.LENGTH_LONG);
    }
  }
}
