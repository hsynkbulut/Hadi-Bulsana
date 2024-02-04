// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hadi_bulsana/common/constants/image_paths.dart';

class Popular {
  String imageUrl;
  String title; //İlan başlığı
  String city;
  String district; //ilçe
  String description;
  String? rating;
  String prices;
  String room;
  String livingRoom;
  String? kitchen;
  String homeOwner;

  //List<Activity> activities;

  Popular(
      {required this.imageUrl,
      required this.title,
      required this.city,
      required this.district,
      required this.description,
      this.rating,
      required this.prices,
      required this.room,
      required this.livingRoom,
      this.kitchen,
      required this.homeOwner});
}

//destination data
List<Popular> destinations = [
  Popular(
      imageUrl: ImagePaths.house1,
      title: 'Ankara\'da 2+1 Kiralık apart',
      city: 'Ankara',
      district: 'Elmadağ',
      description: 'Ankara\'nın göbeğinde çok temiz apart.',
      rating: '4.1',
      prices: '7500',
      room: '2',
      livingRoom: '1',
      kitchen: '1',
      homeOwner: 'Ahmet Polat'),
  Popular(
      imageUrl: ImagePaths.house2,
      title: 'Konya\'da 3+1 Kiralık apart',
      city: 'Konya',
      district: 'Selçuklu',
      description: 'Konya\'nın göbeğinde çok temiz apart.',
      rating: '3.3',
      prices: '7100',
      room: '3',
      livingRoom: '1',
      kitchen: '1',
      homeOwner: 'Cansu Demir'),
  Popular(
      imageUrl: ImagePaths.house3,
      title: 'Konya\'da 1+1 Kiralık apart',
      city: 'Konya',
      district: 'Meram',
      description: 'Konya\'nın göbeğinde çok temiz apart.',
      rating: '2.9',
      prices: '6500',
      room: '1',
      livingRoom: '1',
      kitchen: '1',
      homeOwner: 'Zeki Ökten'),
  Popular(
      imageUrl: ImagePaths.house4,
      title: 'Ankara\'da 2+1 Kiralık apart',
      city: 'Ankara',
      district: 'Çankaya',
      description: 'Ankara\'nın göbeğinde çok temiz apart.',
      rating: '2.7',
      prices: '10000',
      room: '2',
      livingRoom: '1',
      kitchen: '1',
      homeOwner: 'Hilmi Taş'),
  Popular(
      imageUrl: ImagePaths.house5,
      title: 'İzmir\'de 3+1 Kiralık apart',
      city: 'İzmir',
      district: 'Menemen',
      description: 'İzmir\'in göbeğinde çok temiz apart.',
      rating: '3.5',
      prices: '7300',
      room: '3',
      livingRoom: '1',
      kitchen: '1',
      homeOwner: 'Beren Ilgın'),
  Popular(
      imageUrl: ImagePaths.house6,
      title: 'İzmir\'de 2+1 Kiralık apart',
      city: 'İzmir',
      district: 'Torbalı',
      description: 'İzmir\'in göbeğinde çok temiz apart.',
      rating: '3.2',
      prices: '6900',
      room: '2',
      livingRoom: '1',
      kitchen: '1',
      homeOwner: 'Nazan Atlı'),
  Popular(
      imageUrl: ImagePaths.house7,
      title: 'Eskişehir\'de 3+1 Kiralık apart',
      city: 'Eskişehir',
      district: 'Tepebaşı',
      description: 'Eskişehir\'in göbeğinde çok temiz apart.',
      rating: '4.8',
      prices: '7300',
      room: '3',
      livingRoom: '1',
      kitchen: '1',
      homeOwner: 'Hasan Kırat'),
];
