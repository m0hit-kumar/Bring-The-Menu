import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/controller/auth_controller.dart';
import 'package:bring_the_menu/views/admin/otp/otp.dart';
import 'package:bring_the_menu/views/utility_classes/mytheme.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import 'package:velocity_x/velocity_x.dart';

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
                  backgroundColor: MyTheme.LightBlue,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(height: Get.height / 10),
                            SvgPicture.asset(
                              'assets/images/restaurant.svg',
                              width: Get.width / 1.4,
                            ),
                            SizedBox(height: Get.height / 30),
                            Text(
                              textAlign: TextAlign.center,
                              'Bring The Menu',
                              style: TextStyle(
                                  color: MyTheme.darkBlue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal,
                                  wordSpacing: 0.0),
                            ),
                            Text(
                              'Go Digital',
                              style: TextStyle(
                                  color: MyTheme.darkBlue, fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: Get.height / 20),
                            InputWidget(
                                constants: constants,
                                title: 'Email',
                                hintText: 'eg: youremail@gmail.com',
                                controller: emailController,
                                isObscrue: false),
                            SizedBox(height: 10),
                            InputWidget(
                                constants: constants,
                                title: 'Password',
                                hintText: 'eg: aStrongPassword#@',
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                isObscrue: true),
                            SizedBox(height: Get.height / 25),
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
                                  ElevatedButton(
                                    
                                    onPressed: () {
                                      final username =
                                          emailController.text.trim();
                                      final password =
                                          passwordController.text.trim();
                                      authManager.login(username, password);
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor: MaterialStatePropertyAll( MyTheme.MidBlue),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: MyTheme.LightBlue,
                                      ),
                                    ),
                                  ),
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
