import 'package:bring_the_menu/views/client/onboard.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClientOnBoard(),
      theme: ThemeData(fontFamily: 'Lexend'),
    );
  }
}
