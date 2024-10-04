// import 'package:flutter/material.dart';
//
// class Product {
//   final String image, title, description, arLink;
//   final int price, id;
//   final Color color;
//
//   Product({
//     required this.image,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.id,
//     required this.color,
//     required this.arLink,
//   });
// }
//
// List<Product> products = [
//   Product(
//     id: 1,
//     title: "Lite Runner Sneakers",
//     price: 150,
//     description:
//         "Made for an outdoor run or a city walk, the comfortable, anti-slip Lite Runner low top sneakers for men are crafted from leather and water-resistant fabric.",
//     image: "assets/images/shoe_1.png",
//     color: const Color(0xFFAEAEAE),
//     arLink: "https://demo.vyking.app/?shoe=64",
//   ),
//   Product(
//       id: 2,
//       arLink: "https://demo.vyking.app/?shoe=54",
//       title: "Gazelle",
//       price: 220,
//       description:
//           "Gazelle may have started as a trainer , but it's had a long run : this low- profile classic boasts a light weight and suede super",
//       image: "assets/images/shoe_2.png",
//       color: const Color(0xFF3D82AE)),
//   Product(
//       id: 3,
//       arLink: "https://demo.vyking.app/?shoe=50",
//       title: "Suede Classic",
//       price: 120,
//       description:
//           "The Suede Classic XXI feature as a full suede upper alongside some modern touches for an improved overall quality and feel to an all time great",
//       image: "assets/images/shoe_3.png",
//       color: const Color(0xFFD3A984)),
//   Product(
//       id: 4,
//       arLink: "https://demo.vyking.app/?shoe=65",
//       title: "Cloud Rock 2",
//       price: 100,
//       description:
//           "On's hero waterproof hiking boot made for all trails , and all weathers. Explore the unknown",
//       image: "assets/images/shoe_4.png",
//       color: const Color(0xFF989493)),
//   Product(
//       id: 5,
//       arLink: "https://demo.vyking.app/?shoe=66",
//       title: "2002R",
//       price: 130,
//       description:
//           "Inspired by the MR2002 , a high-end running model originally release in 2010, the 2002R offers a ready-to- wear take on sleek , technical design",
//       image: "assets/images/shoe_5.png",
//       color: const Color(0xFFE6B398)),
//   Product(
//       id: 6,
//       arLink: "https://demo.vyking.app/?shoe=183",
//       title: "Dunk Low 'Wear & Tear",
//       price: 110,
//       description:
//           "The Soles made from rubber are not only weatherproof and durable but also provide secure grip all year round in any weather",
//       image: "assets/images/shoe_6.png",
//       color: const Color(0xFFFB7883)),
//   Product(
//       id: 7,
//       arLink: "https://demo.vyking.app/?shoe=184",
//       title: "WMNS V2K RUN",
//       price: 90,
//       description:
//           "Fas Forward. Rewind. Doesn't matter -this shoes takes retro into the future",
//       image: "assets/images/shoe_7.png",
//       color: const Color(0xFFAEAEAE)),
// ];
//
// String dummyText =
//     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel {
  final String image;
  final String title;
  final String description;
  final String arLink;
  final int price;
  final String id;
  final Color color;

  ProductModel({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.id,
    required this.color,
    required this.arLink,
  });

  // Factory method to create a Product object from Firestore document
  factory ProductModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      image: data['image'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0,
      color: Color(
          data['color'] ?? 0xFFFFFFFF), // Assuming color is stored as an int
      arLink: data['arLink'] ?? '',
    );
  }
}
