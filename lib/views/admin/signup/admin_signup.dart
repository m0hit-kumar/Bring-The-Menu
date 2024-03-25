import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/controller/auth_controller.dart';
import 'package:bring_the_menu/views/admin/otp/otp.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import '../../../controller/database_controller.dart';

class AdminSignUp extends StatefulWidget {
  const AdminSignUp({super.key});

  @override
  State<AdminSignUp> createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  final constants = Get.put(Constants());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authManager = Get.put(AuthManager());
  final databaseController = Get.put(DatabaseController()); // Add this line

  var errorCode;

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
                                keyboardType: TextInputType.visiblePassword,
                                isObscrue: true),
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

                                        authManager.createUser(
                                            username, password);
                                      },
                                      width: Get.width / 3.2,
                                      height: Get.height / 20),
                                  InkWell(
                                    onTap: () {
                                      final username =
                                          emailController.text.trim();
                                      final password =
                                          passwordController.text.trim();
                                      authManager.login(username, password);
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
