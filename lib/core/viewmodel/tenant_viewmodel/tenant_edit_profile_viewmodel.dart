import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/models/tenant_model.dart';
import 'package:hadi_bulsana/core/services/authentication/auth_service_tenant.dart';

class TenantEditProfileViewModel with ChangeNotifier {
  final AuthServiceTenant _authServiceTenant = AuthServiceTenant();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  File? profilePhoto;

  Future<void> updateSignUp(BuildContext context, Tenant tenant) async {
    String newName = nameController.text;
    String newSurname = surnameController.text;
    String newEmail = emailController.text;
    String newPhoneNumber = phoneNumberController.text;
    String newPassword = passwordController.text;
    String newCity = cityController.text;
    String newDistrict = districtController.text;

    Tenant updatedTenant = Tenant(
      userID: tenant.userID,
      name: newName,
      surname: newSurname,
      email: newEmail,
      phoneNumber: newPhoneNumber,
      password: newPassword,
      city: newCity,
      district: newDistrict,
    );

    await _authServiceTenant
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
      Navigator.pop(context, updatedTenant);
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
