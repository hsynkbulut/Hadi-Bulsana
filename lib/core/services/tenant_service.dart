// ignore_for_file: avoid_print, avoid_renaming_method_parameters

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hadi_bulsana/core/models/tenant_model.dart';
import 'package:hadi_bulsana/core/services/user_service.dart';

class TenantService extends UserService<Tenant> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future createUser(Tenant tenant, [File? profilePhoto]) async {
    try {
      String uid =
          _auth.currentUser!.uid; // Kiracı kimliğini Firebase Auth'tan al
      DocumentReference userRef = _firestore
          .collection('tenants')
          .doc(uid); // Belge referansını kiracı kimliği ile oluştur
      await userRef.set(tenant.toMap()); // Belgeyi veritabanına kaydet
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future updateUser(Tenant tenant, [File? newProfilePhoto]) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('tenants').doc(uid).update(tenant.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> deleteUser(String userID) async {
    try {
      await _firestore.collection('tenants').doc(userID).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Tenant?> getUser() async {
    try {
      String uid = _auth.currentUser!.uid;

      DocumentSnapshot doc =
          await _firestore.collection('tenants').doc(uid).get();

      if (doc.exists) {
        Tenant tenant = Tenant.fromMap(doc.data() as Map<String, dynamic>);
        return tenant;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
