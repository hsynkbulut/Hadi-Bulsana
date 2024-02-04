import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hadi_bulsana/core/models/tenant_model.dart';
import 'package:hadi_bulsana/core/services/authentication/auth_service_tenant.dart';
import 'package:hadi_bulsana/core/services/tenant_service.dart';
import 'package:hadi_bulsana/core/utils/routing/route_constant.dart';
import 'package:hadi_bulsana/ui/views/onboard/onboard.dart';

class TenantProfileViewModel {
  final AuthServiceTenant authService = AuthServiceTenant();
  final TenantService tenantService = TenantService();
  Tenant? tenant;

  late StreamController<bool> _updateController;

  TenantProfileViewModel() {
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

  String? name;
  String? surname;
  String? email;
  String? phoneNumber;
  String? city;
  String? district;
  bool isImageFullScreen = false;

  Future<void> getUserInfo() async {
    tenant = (await tenantService.getUser())!;

    name = tenant!.name;
    surname = tenant!.surname;
    email = tenant!.email;
    phoneNumber = tenant!.phoneNumber;
    city = tenant!.city;
    district = tenant!.district;

    notifyUIUpdate();
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
                Navigator.pushNamed(
                    context, RouteConstant.tabbarTenantAuthRoute);
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OnboardScreen()),
      );
      Fluttertoast.showToast(
          msg: "Çıkış yapıldı", toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Çıkış yapılamadı: $e", toastLength: Toast.LENGTH_LONG);
    }
  }

  void updateUserInfo(Tenant updatedTenant) {
    tenant = updatedTenant;
    name = updatedTenant.name;
    surname = updatedTenant.surname;
    email = updatedTenant.email;
    city = updatedTenant.city;
    district = updatedTenant.district;

    notifyUIUpdate();
  }
}
