import 'dart:html';

import 'package:bring_the_menu/views/admin/dashboard/admin_dashboard.dart';
import 'package:bring_the_menu/views/admin/login/admin_login.dart';
import 'package:bring_the_menu/views/admin/otp/otp.dart';
import 'package:bring_the_menu/views/client/onBoard/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:bring_the_menu/views/admin/signup/admin_signup.dart';
import 'package:bring_the_menu/views/client/onBoard/onboard.dart';
import 'package:get/get.dart';
import 'package:bring_the_menu/views/admin/complete-profile/complete-profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  String _documentId;
  String documentId = "";
  @override
  void initState() {
    super.initState();
    _extractDocumentIdFromUrl();
  }

  void _extractDocumentIdFromUrl() {
    final Uri uri = Uri.parse(window.location.href);
    documentId = uri.path.toString();
    // print("$uri , $documentId");
  }

  @override
  Widget build(BuildContext context) {
    // print(documentId);
    return GetMaterialApp(
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     return const AdminSignUp();
      //   },
      // ),

      debugShowCheckedModeBanner: false,
      initialRoute: '/menu',
      theme: ThemeData(fontFamily: 'Lexend'),
      getPages: [
        GetPage(name: '/menu', page: () => MyMenu(documentId: documentId)),
        GetPage(name: '/clientOnBoard', page: () => ClientOnBoard()),
        GetPage(name: '/adminSignup', page: () => const AdminSignUp()),
        GetPage(
            name: '/adminCompleteProfile',
            page: () => const AdminCompleteProfile()),
        GetPage(name: '/adminDashboard', page: () => const AdminDashboard()),
        GetPage(name: '/adminLogin', page: () => const AdminLogin()),
        GetPage(name: '/adminOTP', page: () => const AdminOTPScreen()),
      ],
    );
  }
}
