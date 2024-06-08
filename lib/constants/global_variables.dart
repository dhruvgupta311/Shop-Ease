import 'package:flutter/material.dart';
String uri = 'http://172.16.1.205:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 234, 182, 0.874),
      Color.fromRGBO(255, 234, 182, 1),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(48, 22, 12, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromARGB(255, 30, 17, 11)!;
  static const unselectedNavBarColor = Color.fromARGB(221, 26, 11, 11);

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://i.pinimg.com/564x/27/5c/fc/275cfc51e60c6e3ef11101b3890bafa8.jpg',
    'https://i.pinimg.com/564x/27/5c/fc/275cfc51e60c6e3ef11101b3890bafa8.jpg',
    'https://i.pinimg.com/564x/27/5c/fc/275cfc51e60c6e3ef11101b3890bafa8.jpg',
    'https://i.pinimg.com/564x/27/5c/fc/275cfc51e60c6e3ef11101b3890bafa8.jpg',
    'https://i.pinimg.com/564x/27/5c/fc/275cfc51e60c6e3ef11101b3890bafa8.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'grocery',
      'image': 'assets/images/grocery.jpeg',
    },
    {
      'title': 'electronics',
      'image': 'assets/images/electronics.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}
