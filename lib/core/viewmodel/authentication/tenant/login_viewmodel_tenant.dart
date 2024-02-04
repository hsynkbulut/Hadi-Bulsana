// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hadi_bulsana/core/services/authentication/auth_service_tenant.dart';
import 'package:hadi_bulsana/ui/widgets/tenant_widgets/custom_bottom_navbar.dart';

class LoginViewModelTenant with ChangeNotifier {
  final AuthServiceTenant _authServiceTenant = AuthServiceTenant();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    String? email = emailController.text;
    String? password = passwordController.text;

    if (email != null && password != null) {
      String? tenantID =
          await _authServiceTenant.signInUser(email: email, password: password);

      if (tenantID != null) {
        //Navigator.pushNamed(context, RouteConstant.bottomNaviRoute);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomBottomNavBar()),
        );
      } else {
        // Giriş başarısız, hata işlemleri
      }
    }
  }
}
