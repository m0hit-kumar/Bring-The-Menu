import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MenuItem {
  final String name;
  final double rating;
  final int price;
  final bool veg;
  final String type;
  MenuItem(
      {required this.name,
      required this.rating,
      required this.price,
      required this.veg,
      required this.type});

  static fromQuerySnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<MenuItem> menuItems = [];
    for (var document in snapshot.data!.docs) {
      Map data = document.data() as Map;
      menuItems.add(
        MenuItem(
          price: data['price'],
          name: data['name'],
          rating: data['rating'],
          type: data['type'],
          veg: data['veg'],
        ),
      );
    }
    return menuItems;
  }
}
