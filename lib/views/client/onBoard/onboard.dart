import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/utility_classes/mytheme.dart';
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
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {},
              child: Icon(
                Icons.notifications_sharp,
                color: constants.whiteTextColor,
              )),
        ],
        centerTitle: true,
        title: const Text(
          // restruant,
          "Bring The Menu",

          style: TextStyle(
              fontSize: 20,
              color: MyTheme.darkBlue,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: Get.height / 10),
                SvgPicture.asset(
                  'assets/images/resturant.svg',
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
                  style:
                      TextStyle(color: constants.whiteTextColor, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height / 10),
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
      ),
    );
  }
}
