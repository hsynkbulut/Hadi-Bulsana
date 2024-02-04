// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hadi_bulsana/core/models/house_listing_model.dart';

class HouseListingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ev ilanı oluşturma
  Future createHouseListing(HouseListing houseListing, List<File> photo) async {
    try {
      // ev sahibinin uid'sini almak için _auth.currentUser?.uid kullanma
      await _firestore
          .collection('homeowners')
          .doc(_auth.currentUser
              ?.uid) // homeowners koleksiyonundan uid'ye göre bir belge seçme
          .collection(
              'houselistings') // o belgenin altındaki houselistings koleksiyonuna erişme
          .doc(houseListing.houseListingID)
          .set(houseListing.toMap());

      // evin fotoğraflarını storage'a yükleme ve linklerini alıp firestore'a kaydetme
      await uploadPhotosAndGetLinks(
          houseListing.houseListingID.toString(), photo);
    } catch (e) {
      print(e.toString());
    }
  }

  // ev ilanı güncelleme
  Future updateHouseListing(HouseListing houseListing, List<File> photo) async {
    try {
      // kullanıcının uid'sini almak için _auth.currentUser?.uid kullanma
      await _firestore
          .collection('homeowners')
          .doc(_auth.currentUser
              ?.uid) // users koleksiyonundan uid'ye göre bir belge seçme
          .collection(
              'houselistings') // o belgenin altındaki animaladoptions koleksiyonuna erişme
          .doc(houseListing.houseListingID.toString())
          .update(houseListing.toMap());

      // hayvanın fotoğraflarını storage'a yükleme
      await uploadPhotosAndGetLinks(
          houseListing.houseListingID.toString(), photo);
    } catch (e) {
      print(e.toString());
    }
  }

  // ev ilanı silme
  Future deleteHouseListing(String houseListingID) async {
    try {
      // kullanıcının uid'sini almak için _auth.currentUser?.uid kullanma
      await _firestore
          .collection('homeowners')
          .doc(_auth.currentUser
              ?.uid) // users koleksiyonundan uid'ye göre bir belge seçme
          .collection(
              'houselistings') // o belgenin altındaki animaladoptions koleksiyonuna erişme
          .doc(houseListingID)
          .delete();

      // hayvanın fotoğraflarını storage'dan silme
      await deletePhotos(houseListingID);
    } catch (e) {
      print(e.toString());
    }
  }

  // İlgili ev sahibinin tüm ev ilanlarını silme
  Future deleteHouseListings() async {
    try {
      // kullanıcının uid'sini almak için _auth.currentUser?.uid kullanma
      await _firestore
          .collection('homeowners')
          .doc(_auth.currentUser
              ?.uid) // homeowners koleksiyonundan uid'ye göre bir belge seçme
          .delete();

      // hayvanın fotoğraflarını storage'dan silme
      //await deletePhotos(houseListingID);
    } catch (e) {
      print(e.toString());
    }
  }

  // İlgili kullanıcıya ait olan tüm ilanları siler
  Future<void> deleteHouseListingsOfUser(String userID) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('homeowners')
          .doc(userID)
          .collection('houselistings')
          .get();

      List<String> houseListingIDs = query.docs.map((doc) => doc.id).toList();

      for (String houseListingID in houseListingIDs) {
        await deleteHouseListing(houseListingID);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Kiralanacak evi getiren fonksiyon
  Future<HouseListing?> getHouseListing(String houseListingID) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('homeowners')
          .doc(_auth.currentUser?.uid)
          .collection('houselistings')
          .doc(houseListingID)
          .get();

      if (doc.exists) {
        HouseListing animal =
            HouseListing.fromMap(doc.data() as Map<String, dynamic>);
        return animal;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Tüm ev ilanları listesini getirme
  /*
  Future<List<HouseListing>> getHouseListings() async {
    try {
      // tüm ev sahiplerinin ilanlarını getirmek için homeowners koleksiyonunu değil, houselistings koleksiyon grubunu sorgulama
      QuerySnapshot query = await _firestore
          .collectionGroup(
              'houselistings') // houselistings koleksiyon grubunu seçme
          .orderBy('houseListingID')
          .get();
      List<HouseListing> houseListings = query.docs
          .map(
              (doc) => HouseListing.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return houseListings;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  */

  // Tüm ev ilanları listesini getirme
  Future<List<HouseListing>> getHouseListings() async {
    try {
      // tüm ev sahiplerinin ilanlarını getirmek için homeowners koleksiyonunu değil, houselistings koleksiyon grubunu sorgulama
      QuerySnapshot query = await _firestore
          .collectionGroup('houselistings')
          .get(); // houselistings koleksiyon grubunu seçme
      List<HouseListing> houseListings = query.docs
          .map(
              (doc) => HouseListing.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return houseListings;
    } catch (e) {
      print('getQuestions() Service Hatası: $e');
      return [];
    }
  }

  // Ev sahibinin kendi ilanlarını getiren özel bir fonksiyon
  Future<List<HouseListing>> getUserHouseListings() async {
    try {
      String uid = _auth.currentUser!.uid;

      QuerySnapshot query = await _firestore
          .collection('homeowners')
          .doc(uid)
          .collection('houselistings')
          .orderBy('houseListingID')
          .get();

      List<HouseListing> animals = query.docs
          .map(
              (doc) => HouseListing.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return animals;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // fotoğrafları storage'a yükleme ve linklerini alıp firestore'a kaydetme fonksiyonu
  Future uploadPhotosAndGetLinks(
      String houseListingID, List<File> photos) async {
    try {
      // linkleri tutmak için boş bir liste oluşturma
      List<String> links = [];
      for (int i = 0; i < photos.length; i++) {
        // fotoğrafı File olarak okuma
        File photo = photos[i];
        // storage'da referans oluşturma
        Reference ref = _storage
            .ref()
            .child('homeowners')
            .child(_auth.currentUser!.uid)
            .child('houselistings')
            .child(houseListingID)
            //.child('photos')
            .child('photo$i.jpg');
        // fotoğrafı storage'a yükleme
        UploadTask task = ref.putFile(photo);
        await task.whenComplete(() {});
        // fotoğrafın linkini alıp listeye ekleme
        String link = await ref.getDownloadURL();
        links.add(link);
      }
      // linkleri firestore'a kaydetme
      await _firestore
          .collection('homeowners')
          .doc(_auth.currentUser?.uid)
          .collection('houselistings')
          .doc(houseListingID)
          .update({'photos': links}); // Firebase'de photos listesini güncelleme
    } catch (e) {
      print(e.toString());
    }
  }

  // fotoğrafları storage'dan silme fonksiyonu
  Future deletePhotos(String houseListingID) async {
    try {
      // storage'da referans oluşturma
      Reference ref = _storage
          .ref()
          .child('homeowners')
          .child(_auth.currentUser!.uid)
          .child('houselistings')
          .child(houseListingID);
      //.child('photos');
      // referansın altındaki tüm fotoğrafları listeleme
      ListResult result = await ref.listAll();
      for (Reference item in result.items) {
        // her bir fotoğrafı silme
        await item.delete();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Sadece kiralanmış olan evleri (yyani isRented değeri true olanlar) getirmek için
  Future<List<HouseListing>> getRentedHouseListings() async {
    try {
      String uid = _auth.currentUser!.uid;

      QuerySnapshot query = await _firestore
          .collection('homeowners')
          .doc(uid)
          .collection('houselistings')
          .orderBy('houseListingID')
          .where('isRented', isEqualTo: true) // Kiralanmış evleri getir
          .get();

      List<HouseListing> rentedListings = query.docs
          .map(
              (doc) => HouseListing.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return rentedListings;
    } catch (e) {
      print('Kiralanmış evleri getirirken hata: $e');
      return [];
    }
  }

  // Ev kiralama durumunu (isRented) değiştiren fonksiyon (Kiracı için)
  Future<void> toggleRentalStatus(
      String houseListingID, bool currentStatus) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collectionGroup('houselistings') // collectionGroup kullanımı
          .where('houseListingID', isEqualTo: houseListingID)
          .get();

      // Belirtilen houseListingID'ye sahip olan belgeyi al
      querySnapshot.docs.forEach((doc) async {
        // Veritabanında ilgili ev ilanının isRented değerini tersine çevirme
        await doc.reference.set(
          {'isRented': !currentStatus},
          SetOptions(merge: true),
        );
      });
    } catch (e) {
      //print(e.toString());
      print('toggleRentalStatus() Service Hatası: $e');
    }
  }
}
