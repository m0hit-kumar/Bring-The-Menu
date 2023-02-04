import "package:flutter/material.dart";

class OrderPage extends StatelessWidget {
  OrderPage({super.key, required this.orders});
  final Map<String, int> orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("$orders"),
    ));
  }
}
