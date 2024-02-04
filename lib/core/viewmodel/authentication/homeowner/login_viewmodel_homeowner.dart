// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/services/authentication/auth_service_homeowner.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';

class LoginViewModelHomeOwner with ChangeNotifier {
  final AuthServiceHomeOwner _authServiceHomeOwner = AuthServiceHomeOwner();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    String? email = emailController.text;
    String? password = passwordController.text;

    if (email != null && password != null) {
      String? homeOwnerID = await _authServiceHomeOwner.signInUser(
          email: email, password: password);

      if (homeOwnerID != null) {
        // Giriş başarılı, yapılacak işlemler
        // Örneğin: Ana sayfaya yönlendirme
        Navigator.pushNamed(context, RouteConstant.hostDashboardRoute);
      } else {
        // Giriş başarısız, hata işlemleri
        // Örneğin: Hatalı giriş bilgileri mesajı gösterme
      }
    }
  }
}
