// Ev sahibi sınıfı (HomeOwner)
import 'package:hadi_bulsana/core/models/users_model.dart';

class HomeOwner extends Users {
  //String? homeOwnerID;
  String? profilePhoto;

  HomeOwner({
    //this.homeOwnerID,
    String? userID,
    required String name,
    required String surname,
    required String email,
    required String phoneNumber,
    required String password,
    this.profilePhoto,
  }) : super(
          userID: userID,
          name: name,
          surname: surname,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
        );

  // HomeOwner sınıfını Map'e dönüştürme
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    //map['homeOwnerID'] = homeOwnerID;
    map['profilePhoto'] = profilePhoto;
    return map;
  }

  // Map'i HomeOwner sınıfına dönüştürme
  HomeOwner.fromMap(Map<String, dynamic> map)
      : //homeOwnerID = map['homeOwnerID'],
        profilePhoto = map['profilePhoto'],
        super(
          userID: map['userID'],
          name: map['name'],
          surname: map['surname'],
          email: map['email'],
          phoneNumber: map['phoneNumber'],
          password: map['password'],
        );
}
