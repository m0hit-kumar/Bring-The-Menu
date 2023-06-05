import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/admin/signup/admin_signup.dart';
import 'package:bring_the_menu/views/utility_classes/mytheme.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final constants = Get.put(Constants());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'assets/images/restaurant.svg',
                  width: Get.width / 1.4,
                ),
                SizedBox(height: Get.height / 13),
                const Text(
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
                  'Login Now',
                  style: TextStyle(color: MyTheme.darkBlue, fontSize: 24),
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
                    isObscrue: false),
                SizedBox(height: Get.height / 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          constants: constants,
                          title: 'Login',
                          onTap: () {
                            // To be implemented by mohit bhaiya.
                          },
                          width: Get.width / 3.2,
                          height: Get.height / 20),
                      // InkWell(
                      //   onTap: () {
                      //     Get.to(const AdminSignUp());
                      //   },
                      //   child: Text(
                      //     'Sign Up',
                      //     style: TextStyle(color: constants.whiteTextColor),
                      //   ),
                      // )
                      ElevatedButton(
                        onPressed: () {
                          Get.to(const AdminSignUp());
                        },

                         style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              const MaterialStatePropertyAll(MyTheme.MidBlue),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: MyTheme.LightBlue,
                          ),
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
  }
}
