import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/widgets/admin_option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final constants = Get.put(Constants());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Bring the menu admin',
          style: TextStyle(color: constants.whiteTextColor),
        ),
        backgroundColor: constants.backgroundColor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: constants.whiteTextColor,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: constants.whiteTextColor,
              )),
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(Get.height / 200),
            child: Container(
              width: double.infinity,
              height: 2,
              color: constants.themeColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height / 30),
            Text(
              'Welcome, Admin',
              style: TextStyle(
                  color: constants.whiteTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Get.height / 30),
            Row(
              children: [
                AdminOptionCard(
                  constants: constants,
                  title: 'Menu Page',
                  imagePath: 'assets/images/menu.svg',
                ),
                const SizedBox(width: 3),
                AdminOptionCard(
                  constants: constants,
                  title: 'Reviews',
                  imagePath: 'assets/images/reviews.svg',
                )
              ],
            ),
            SizedBox(height: Get.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Orders',
                  style:
                      TextStyle(color: constants.whiteTextColor, fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'See All >',
                    style: TextStyle(
                        color: constants.whiteTextColor, fontSize: 14),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
