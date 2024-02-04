import 'dart:io';

import 'package:flutter/material.dart';

abstract class IAuthenticationService {
  Future<String?> signUpUser({
    required String name,
    required String surname,
    required String email,
    required String phoneNumber,
    required String password,
    String? city,
    String? district,
    File? profilePhoto,
  });

  Future<String?> signInUser({
    required String email,
    required String password,
  });

  Future<void> signOutUser();

  Future<void> resetPasswordUser(BuildContext context, String email);

  Future<void> deleteUser();

  Future<void> updateUserInformation({
    required String newName,
    required String newSurname,
    required String newEmail,
    required String newPhoneNumber,
    required String newPassword,
    String? newCity,
    String? newDistrict,
    File? profilePhoto,
  });
}

class AuthenticationService implements IAuthenticationService {
  @override
  Future<String?> signUpUser({
    required String name,
    required String surname,
    required String email,
    required String phoneNumber,
    required String password,
    String? city,
    String? district,
    File? profilePhoto,
  }) async {
    // Implementasyon burada yapılacak
    return null;
  }

  @override
  Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
    // Implementasyon burada yapılacak
    return null;
  }

  @override
  Future<void> signOutUser() async {
    // Implementasyon burada yapılacak
  }

  @override
  Future<void> resetPasswordUser(BuildContext context, String email) async {
    // Implementasyon burada yapılacak
  }

  @override
  Future<void> deleteUser() async {
    // Implementasyon burada yapılacak
  }

  @override
  Future<void> updateUserInformation({
    required String newName,
    required String newSurname,
    required String newEmail,
    required String newPhoneNumber,
    required String newPassword,
    String? newCity,
    String? newDistrict,
    File? profilePhoto,
  }) async {
    // Implementasyon burada yapılacak
  }
}
