import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating});
  final int rating;
  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        Icons.star,
        size: 14,
        color: i < rating ? Colors.orange : Colors.grey,
      ));
    }
    return Row(
      children: stars,
    );
  }
}
