import 'package:hadi_bulsana/core/models/users_model.dart';

// Kiracı sınıfı (Tenant)
class Tenant extends Users {
  //String? tenantID;
  String city;
  String district;

  Tenant({
    //this.tenantID,
    String? userID,
    required String name,
    required String surname,
    required String email,
    required String phoneNumber,
    required String password,
    required this.city,
    required this.district,
  }) : super(
          //userID: tenantID,
          userID: userID,
          name: name,
          surname: surname,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
        );

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    //map['tenantID'] = tenantID;
    map['city'] = city;
    map['district'] = district;
    return map;
  }

  // Map'i HomeOwner sınıfına dönüştürme
  Tenant.fromMap(Map<String, dynamic> map)
      : //tenantID = map['tenantID'],
        city = map['city'],
        district = map['district'],
        super(
          //userID: map['tenantID'],
          userID: map['userID'],
          name: map['name'],
          surname: map['surname'],
          email: map['email'],
          phoneNumber: map['phoneNumber'],
          password: map['password'],
        );
}


/*
class Tenants {
  String? tenantID;
  String name;
  String surname;
  String email;
  String phoneNumber;
  String password;

  Tenants({
    this.tenantID,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  // Tenants sınıfını Map'e dönüştürme
  Map<String, dynamic> toMap() {
    return {
      'tenantID': tenantID,
      'name': name,
      'surname': surname,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  // Map'i Tenants sınıfına dönüştürme
  Tenants.fromMap(Map<String, dynamic> map)
      : tenantID = map['tenantID'],
        name = map['name'],
        surname = map['surname'],
        email = map['email'],
        phoneNumber = map['phoneNumber'],
        password = map['password'];
}
*/