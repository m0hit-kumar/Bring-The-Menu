import 'package:bring_the_menu/views/admin/login/admin_login.dart';
import 'package:bring_the_menu/views/admin/signup/admin_signup.dart';
import 'package:bring_the_menu/views/client/onBoard/onboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'adminSignup',
      theme: ThemeData(fontFamily: 'Lexend'),
      getPages: [
        GetPage(name: '/clientOnBoard', page: () => ClientOnBoard()),
        GetPage(name: '/adminSignup', page: () => const AdminSignUp()),
        GetPage(name: '/adminLogin', page: () => const AdminLogin()),
      ],
    );
  }
}
