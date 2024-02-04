import 'dart:io';
import 'package:hadi_bulsana/core/models/users_model.dart';

abstract class IUserService<T extends Users> {
  Future createUser(T user, [File? profilePhoto]);
  Future updateUser(T user, [File? newProfilePhoto]);
  Future<void> deleteUser(String userID);
  Future<T?> getUser();
}

class UserService<T extends Users> implements IUserService<T> {
  @override
  Future createUser(T user, [File? profilePhoto]) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String userID) {
    throw UnimplementedError();
  }

  @override
  Future<T?> getUser() {
    throw UnimplementedError();
  }

  @override
  Future updateUser(T user, [File? newProfilePhoto]) {
    throw UnimplementedError();
  }
}
