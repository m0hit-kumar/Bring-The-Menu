import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/utility_classes/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AdminOptionCard extends StatelessWidget {
  AdminOptionCard(
      {super.key,
      required this.constants,
      required this.title,
      required this.imagePath});

  final Constants constants;
  String title;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 5.5,
      width: Get.width / 2.5,
      decoration: BoxDecoration(
          color: constants.themeColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SizedBox(height: Get.height / 500),
          Container(
            width: Get.width / 2.55,
            height: Get.height / 7,
            decoration: BoxDecoration(
                color: constants.backgroundColor,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              
              child: SvgPicture.asset(imagePath,width: Get.width / 4.00,
                height: Get.height / 9,
              ),
            ),
          ),
          SizedBox(height: Get.height / 120),
          Text(
            title,
            style:const TextStyle(
                color: MyTheme.WhiteSmoke,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
