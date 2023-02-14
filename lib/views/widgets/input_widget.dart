import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bring_the_menu/constants.dart';

class InputWidget extends StatelessWidget {
  InputWidget(
      {Key? key,
      required this.constants,
      required this.title,
      required this.hintText,
      required this.controller,
      required this.isObscrue})
      : super(key: key);

  final Constants constants;
  String title;
  String hintText;
  TextEditingController controller;
  bool isObscrue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: constants.whiteTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: Get.height / 60),
            Container(
              width: double.infinity,
              height: Get.height / 17,
              decoration: BoxDecoration(
                  color: constants.inputBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: constants.inputStrokeColor)),
              child: TextFormField(
                controller: controller,
                obscureText: isObscrue,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: constants.inputHintTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
