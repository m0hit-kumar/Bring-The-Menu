import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/admin/login/admin_login.dart';
import 'package:bring_the_menu/views/admin/otp/otp.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';

class AdminSignUp extends StatefulWidget {
  const AdminSignUp({super.key});

  @override
  State<AdminSignUp> createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  final constants = Get.put(Constants());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var errorCode;

  Future _createUser(String username, String password) async {
    try {
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
      });
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          msg: error.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            print("00000000000000000${currentUser.uid}");
          }

          return snapshot.hasData
              ? const AdminOTPScreen()
              : Scaffold(
                  backgroundColor: constants.backgroundColor,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(height: Get.height / 10),
                            SvgPicture.asset(
                              'assets/images/foodPlate.svg',
                              width: Get.width / 1.4,
                            ),
                            SizedBox(height: Get.height / 13),
                            Text(
                              'Bring The Menu Admin',
                              style: TextStyle(
                                  color: constants.whiteTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30),
                            ),
                            SizedBox(height: Get.height / 30),
                            Text(
                              'Go Digital',
                              style: TextStyle(
                                  color: constants.whiteTextColor,
                                  fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: Get.height / 20),
                            InputWidget(
                                constants: constants,
                                title: 'Email',
                                hintText: 'eg: youremail@gmail.com',
                                controller: emailController,
                                isObscrue: false),
                            SizedBox(height: Get.height / 20),
                            InputWidget(
                                constants: constants,
                                title: 'Password',
                                hintText: 'eg: aStrongPassword#@',
                                controller: passwordController,
                                isObscrue: false),
                            SizedBox(height: Get.height / 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width / 11),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                      constants: constants,
                                      title: 'Sign Up',
                                      onTap: () {
                                        final username =
                                            emailController.text.trim();
                                        final password =
                                            passwordController.text.trim();

                                        _createUser(username, password);
                                      },
                                      width: Get.width / 3.2,
                                      height: Get.height / 20),
                                  InkWell(
                                    onTap: () {
                                      final username =
                                          emailController.text.trim();
                                      final password =
                                          passwordController.text.trim();
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              password: password,
                                              email: username);
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: constants.whiteTextColor),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        });
  }
}
