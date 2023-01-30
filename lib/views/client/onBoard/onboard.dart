import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClientOnBoard extends StatelessWidget {
  ClientOnBoard({super.key});

  final constants = Get.put(Constants());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: Get.height / 6),
              SvgPicture.asset(
                'assets/images/foodPlate.svg',
                width: Get.width / 1.4,
              ),
              SizedBox(height: Get.height / 13),
              Text(
                'Bring The Menu',
                style: TextStyle(
                    color: constants.whiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 36),
              ),
              SizedBox(height: Get.height / 20),
              Text(
                'Get menu from restaurant you are sitting\n directly on your mobile phone',
                style: TextStyle(color: constants.whiteTextColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height / 3.1),
              CustomButton(
                constants: constants,
                title: 'Continue',
                onTap: () {},
                width: Get.width / 2.7,
                height: Get.height / 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
