import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/widgets/admin_option_card.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
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
            SizedBox(
              height: Get.height / 5.5,
              child: ListView(
                scrollDirection: Axis.horizontal,
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
                  ),
                  const SizedBox(width: 3),
                  AdminOptionCard(
                    constants: constants,
                    title: 'Customers',
                    imagePath: 'assets/images/reviews.svg',
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height / 15),
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
            ),
            SizedBox(height: Get.height / 20),
            SingleChildScrollView(
                child: Column(
              children: [
                OrderCard(constants: constants),
                const SizedBox(height: 10),
                OrderCard(constants: constants),
                const SizedBox(height: 10),
                OrderCard(constants: constants)
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.constants,
  });

  final Constants constants;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height / 10,
      decoration: BoxDecoration(
        border: Border.all(color: constants.themeColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: Get.width / 7,
            height: Get.height / 10,
            child: const Center(
              child: Text(
                '12',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: Get.width / 1.8,
              height: Get.height / 10,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dish Name, Dish Name, Dish Name, Dish',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: Get.width / 4.7,
            height: Get.height / 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints()),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
