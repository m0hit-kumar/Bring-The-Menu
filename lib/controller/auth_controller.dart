import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthManager extends GetxController {
  static get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  Future<void> createUser(String username, String password) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: username, password: password)
        .then((value) {
      Fluttertoast.showToast(
          msg: "Signed In",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Future<void> login(String username, String password) async {
    _auth
        .signInWithEmailAndPassword(password: password, email: username)
        .then((value) {
      Fluttertoast.showToast(
          msg: "Signed In",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Future<void> logout() async {
    _auth.signOut();
  }
}
