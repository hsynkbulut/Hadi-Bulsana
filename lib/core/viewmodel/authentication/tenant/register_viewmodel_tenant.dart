// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/services/authentication/auth_service_tenant.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/custom_bottom_navbar.dart';

class RegisterViewModelTenant with ChangeNotifier {
  final AuthServiceTenant _authServiceTenant = AuthServiceTenant();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  File? profilePhoto;

  Future<void> signUp(BuildContext context) async {
    String? result = await _authServiceTenant.signUpUser(
      name: nameController.text,
      surname: surnameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
      profilePhoto: profilePhoto,
      city: cityController.text,
      district: districtController.text,
    );

    if (result != null) {
      //Navigator.pushNamed(context, RouteConstant.bottomNaviRoute);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CustomBottomNavBar()),
      );
    } else {
      // Kayıt başarısız, kullanıcıya bir hata mesajı gösterebilirsiniz.
    }
  }
}
