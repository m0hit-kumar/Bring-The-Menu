import 'dart:async';

import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/admin/complete-profile/complete-profile.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AdminOTPScreen extends StatefulWidget {
  const AdminOTPScreen({super.key});

  @override
  State<AdminOTPScreen> createState() => _AdminOTPScreenState();
}

class _AdminOTPScreenState extends State<AdminOTPScreen> {
  final constants = Get.put(Constants());

  String currentUserUid = "";
  bool isEmailVerfied = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerfied) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (err) {
      Fluttertoast.showToast(
          msg: "$err",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerfied) {
      // addUser();
      timer?.cancel();
    }
  }

  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return isEmailVerfied
        ? const AdminCompleteProfile()
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
                        'Enter OTP',
                        style: TextStyle(
                            color: constants.whiteTextColor, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height / 20),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width / 15),
                        child: Text(
                          'We had sent an OTP to your entered email address.',
                          style: TextStyle(
                              color: constants.whiteTextColor, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: Get.height / 30),
                      InputWidget(
                          constants: constants,
                          title: 'OTP',
                          hintText: 'eg: 2314',
                          controller: otpController,
                          isObscrue: false),
                      SizedBox(height: Get.height / 20),
                      CustomButton(
                          constants: constants,
                          title: 'Verify',
                          onTap: () {
                            // To be implemented by Mohit Bhaiya.
                          },
                          width: Get.width / 3.2,
                          height: Get.height / 20),
                      SizedBox(height: Get.height / 20),
                      CustomButton(
                          constants: constants,
                          title: 'Send Verification Mail',
                          onTap: canResendEmail ? sendVerificationEmail : null,
                          width: Get.width / 3.2,
                          height: Get.height / 20),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
