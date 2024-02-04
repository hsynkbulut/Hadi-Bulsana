// IUsers Interface
abstract class IUsers {
  String? get userID;
  String get name;
  String get surname;
  String get email;
  String get phoneNumber;
  String get password;
  Map<String, dynamic> toMap();
}

// Users Class
class Users implements IUsers {
  @override
  String? userID;
  @override
  String name;
  @override
  String surname;
  @override
  String email;
  @override
  String phoneNumber;
  @override
  String password;

  Users({
    this.userID,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'surname': surname,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
