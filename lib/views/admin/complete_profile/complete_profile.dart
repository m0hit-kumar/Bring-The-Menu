import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCompleteProfile extends StatefulWidget {
  const AdminCompleteProfile({super.key});

  @override
  State<AdminCompleteProfile> createState() => _AdminCompleteProfileState();
}

class _AdminCompleteProfileState extends State<AdminCompleteProfile> {
  final constants = Get.put(Constants());
  TextEditingController restaurantNameController = TextEditingController();
  Future<DocumentSnapshot<Map<String, dynamic>>> menuRef = FirebaseFirestore
      .instance
      .collection('restaurants')
      .doc("SqNrahYI1KhQaVZXzkcN")
      .get();

  @override
  Widget build(BuildContext context) {
    menuRef.asStream().listen((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data();
        print(data!["name"]);
        // Use the data as needed
      }
    });
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: Get.width / 20, right: Get.width / 20, top: Get.width / 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bring the menu admin',
                style: TextStyle(
                    color: constants.whiteTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Get.height / 50),
              Text(
                'Complete Profile',
                style: TextStyle(
                    color: constants.whiteTextColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),

              SizedBox(height: Get.height / 13),

              InputWidget(
                  constants: constants,
                  title: 'Restaurant Name',
                  hintText: 'eg: My awesome restaurant.',
                  controller: restaurantNameController,
                  isObscrue: false),

              SizedBox(height: Get.height / 30),

              InputWidget(
                  constants: constants,
                  title: 'Lorem Ipsum',
                  hintText: 'eg: Lorem Ipsum Text.',
                  controller: restaurantNameController,
                  isObscrue: false),

              SizedBox(height: Get.height / 30),

              // Map View
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                child: SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Location',
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
                        height: Get.height / 3.5,
                        decoration: BoxDecoration(
                            color: constants.inputBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: constants.inputStrokeColor)),
                        child: Center(
                          child: Text(
                            'Pick Location',
                            style: TextStyle(
                                color: constants.inputStrokeColor,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomButton(
                              constants: constants,
                              title: 'Submit',
                              onTap: () {},
                              width: Get.width / 4,
                              height: Get.height / 18),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
