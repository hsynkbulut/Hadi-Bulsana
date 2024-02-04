import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/models/homeowner_model.dart';
import 'package:hadi_bulsana/core/services/authentication/auth_service_homeowner.dart';

class HostEditProfileViewModel with ChangeNotifier {
  final AuthServiceHomeOwner _authServiceHomeOwner = AuthServiceHomeOwner();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? profilePhoto;

  Future<void> updateSignUp(BuildContext context, HomeOwner homeOwner) async {
    String newName = nameController.text;
    String newSurname = surnameController.text;
    String newEmail = emailController.text;
    String newPhoneNumber = phoneNumberController.text;
    String newPassword = passwordController.text;

    HomeOwner updatedHomeOwner = HomeOwner(
      userID: homeOwner.userID,
      name: newName,
      surname: newSurname,
      email: newEmail,
      phoneNumber: newPhoneNumber,
      password: newPassword,
      profilePhoto: homeOwner.profilePhoto,
    );

    await _authServiceHomeOwner
        .updateUserInformation(
      newName: newName,
      newSurname: newSurname,
      newEmail: newEmail,
      newPhoneNumber: newPhoneNumber,
      newPassword: newPassword,
      profilePhoto: profilePhoto,
    )
        .then((_) {
      // Kullanıcının güncellenmiş profilini Profile sayfasında göstermek için geri dön
      Navigator.pop(context, updatedHomeOwner);
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: Text('Profil güncellenirken bir hata oluştu. $error'),
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
