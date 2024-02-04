// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/services/authentication/auth_service_homeowner.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';

class RegisterViewModelHomeOwner with ChangeNotifier {
  //final AuthServiceHomeOwner _authenticationService = locator<AuthServiceHomeOwner>();
  final AuthServiceHomeOwner _authServiceHomeOwner = AuthServiceHomeOwner();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? profilePhoto;

  Future<void> signUp(BuildContext context) async {
    String? result = await _authServiceHomeOwner.signUpUser(
      name: nameController.text,
      surname: surnameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
      profilePhoto: profilePhoto,
    );

    if (result != null) {
      // Kayıt başarılı, işlemler devam edebilir.
      // Örneğin, ana sayfaya yönlendirme yapabilirsiniz.
      Navigator.pushNamed(context, RouteConstant.hostDashboardRoute);
    } else {
      // Kayıt başarısız, kullanıcıya bir hata mesajı gösterebilirsiniz.
    }
  }
}
