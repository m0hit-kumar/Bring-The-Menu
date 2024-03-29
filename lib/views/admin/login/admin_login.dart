import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/admin/signup/admin_signup.dart';
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
                  'Login Now',
                  style:
                      TextStyle(color: constants.whiteTextColor, fontSize: 24),
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
                      InkWell(
                        onTap: () {
                          Get.to(const AdminSignUp());
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: constants.whiteTextColor),
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
