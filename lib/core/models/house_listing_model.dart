class HouseListing {
  String? houseListingID;
  String title;
  String description;
  int price;
  String room;
  String livingRoom;
  String kitchen;
  String city;
  String district;
  String neighborhood;
  String street;
  String alley;
  String apartmentName;
  int buildingNo;
  int flatNo;
  String phoneNumber;
  String email;
  List<String>?
      photos; //kullanıcının oluşturacağı ilanda yükleyeceği evlerin fotoğraflarını liste şeklinde tutacak.
  bool isRented; // Yeni alan

  HouseListing({
    this.houseListingID,
    required this.title,
    required this.description,
    required this.price,
    required this.room,
    required this.livingRoom,
    required this.kitchen,
    required this.city,
    required this.district,
    required this.neighborhood,
    required this.street,
    required this.alley,
    required this.apartmentName,
    required this.buildingNo,
    required this.flatNo,
    required this.phoneNumber,
    required this.email,
    this.photos,
    required this.isRented, // Yeni parametre
  });

  // HouseListing sınıfını Map'e dönüştürme
  Map<String, dynamic> toMap() {
    return {
      'houseListingID': houseListingID,
      'title': title,
      'description': description,
      'price': price,
      'room': room,
      'livingRoom': livingRoom,
      'kitchen': kitchen,
      'city': city,
      'district': district,
      'neighborhood': neighborhood,
      'street': street,
      'alley': alley,
      'apartmentName': apartmentName,
      'buildingNo': buildingNo,
      'flatNo': flatNo,
      'phoneNumber': phoneNumber,
      'email': email,
      'photos': photos,
      'isRented': isRented, // isRented alanını da Map'e ekle
    };
  }

  // Map'i HouseListing sınıfına dönüştürme
  HouseListing.fromMap(Map<String, dynamic> map)
      : houseListingID = map['houseListingID'],
        title = map['title'],
        description = map['description'],
        price = map['price'],
        room = map['room'],
        livingRoom = map['livingRoom'],
        kitchen = map['kitchen'],
        city = map['city'],
        district = map['district'],
        neighborhood = map['neighborhood'],
        street = map['street'],
        alley = map['alley'],
        apartmentName = map['apartmentName'],
        buildingNo = map['buildingNo'],
        flatNo = map['flatNo'],
        phoneNumber = map['phoneNumber'],
        email = map['email'],
        photos = List<String>.from(map['photos']),
        isRented = map['isRented'];
}
