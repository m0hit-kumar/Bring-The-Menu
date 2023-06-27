import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/controller/database_controller.dart';
import 'package:bring_the_menu/views/admin/dashboard/admin_dashboard.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _formKey = GlobalKey<FormState>();

class AdminCompleteProfile extends StatefulWidget {
  const AdminCompleteProfile({super.key});

  @override
  State<AdminCompleteProfile> createState() => _AdminCompleteProfileState();
}

class _AdminCompleteProfileState extends State<AdminCompleteProfile> {
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }

  final constants = Get.put(Constants());
  final db = Get.put(DatabaseController());
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController upiController = TextEditingController();

  RxString openTime = 'Select Time'.obs;
  RxString closeTime = 'Select Time'.obs;
  String? validateRestaurantName(String? value) {
    if (value == null ||
        value.isEmpty ||
        !RegExp(r'[a-z A-Z]+$').hasMatch(value)) {
      return 'Text not valid';
    }
    // Add additional validation logic if needed
    return null; // Return null if the input is valid
  }

  String? validatePhoneNumber(String? value) {
    if (value == null ||
        value.isEmpty ||
        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
            .hasMatch(value)) {
      return 'phone number is invalid';
    }
    // Add additional validation logic if needed
    return null; // Return null if the input is valid
  }

  String? validateWebsite(String? value) {
    if (value == null ||
        value.isEmpty ||
        !RegExp(r"^www\.[a-zA-Z0-9\-]+(\.[a-zA-Z]{2,})+$").hasMatch(value)) {
      return 'Website URL is invalid';
    }
    // Add additional validation logic if needed
    return null; // Return null if the input is valid
  }

  String? validateUPI(String? value) {
    if (value == null ||
        value.isEmpty ||
        !RegExp(r"^\w+@\w+$").hasMatch(value)) {
      return 'UPI id not valid';
    }
    // Add additional validation logic if needed
    return null; // Return null if the input is valid
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> menuRef = FirebaseFirestore
      .instance
      .collection('restaurants')
      .doc("SqNrahYI1KhQaVZXzkcN")
      .get();

  void _submitForm() {
    db.createProfile(
        restaurantNameController.text,
        phoneController.text,
        websiteController.text,
        upiController.text,
        openTime.string,
        closeTime.string);
  }

  @override
  Widget build(BuildContext context) {
    if (db.profileAvailable == true) {
      return const AdminDashboard();
    } else {
      return Scaffold(
        backgroundColor: constants.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: Get.width / 30,
                right: Get.width / 30,
                top: Get.width / 15),
            child: Form(
              key: _formKey,
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
                  SizedBox(height: Get.height / 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Restuarant Name',
                              style: TextStyle(
                                  color: constants.whiteTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            SizedBox(height: Get.height / 60),
                            Container(
                              width: Get.width / 1.35,
                              height: Get.height / 17,
                              decoration: BoxDecoration(
                                  color: constants.inputBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: constants.inputStrokeColor)),
                              child: Center(
                                child: TextFormField(
                                  obscureText: false,
                                  validator: validateRestaurantName,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'eg: Nara Thai',
                                    hintStyle: TextStyle(
                                        color: constants.inputHintTextColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                    contentPadding: const EdgeInsets.all(14),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Get.height / 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(
                                  color: constants.whiteTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            SizedBox(height: Get.height / 60),
                            Container(
                              width: Get.width / 1.35,
                              height: Get.height / 17,
                              decoration: BoxDecoration(
                                  color: constants.inputBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: constants.inputStrokeColor)),
                              child: TextFormField(
                                obscureText: false,
                                validator: validateRestaurantName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'eg: BKC',
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
                      ],
                    ),
                  ),

                  SizedBox(height: Get.height / 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(
                                  color: constants.whiteTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            SizedBox(height: Get.height / 60),
                            Container(
                              width: Get.width / 3.05,
                              height: Get.height / 17,
                              decoration: BoxDecoration(
                                  color: constants.inputBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: constants.inputStrokeColor)),
                              child: TextFormField(
                                controller: phoneController,
                                obscureText: false,
                                validator: validatePhoneNumber,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '9677456323',
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Website',
                              style: TextStyle(
                                  color: constants.whiteTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            SizedBox(height: Get.height / 60),
                            Container(
                              width: Get.width / 3.05,
                              height: Get.height / 17,
                              decoration: BoxDecoration(
                                  color: constants.inputBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: constants.inputStrokeColor)),
                              child: TextFormField(
                                controller: websiteController,
                                obscureText: false,
                                validator: validateWebsite,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'eg: www.google.com',
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
                      ],
                    ),
                  ),

                  SizedBox(height: Get.height / 30),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'UPI',
                              style: TextStyle(
                                  color: constants.whiteTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            SizedBox(height: Get.height / 60),
                            Container(
                              width: Get.width / 1.35,
                              height: Get.height / 17,
                              decoration: BoxDecoration(
                                  color: constants.inputBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: constants.inputStrokeColor)),
                              child: TextFormField(
                                controller: upiController,
                                obscureText: false,
                                validator: validateUPI,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'eg: 8813@paytm',
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
                      ],
                    ),
                  ),

                  // Opening Closing
                  SizedBox(height: Get.height / 30),
                  Obx(() => Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width / 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Open Time',
                                  style: TextStyle(
                                      color: constants.whiteTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(height: Get.height / 60),
                                InkWell(
                                  onTap: () async {
                                    final TimeOfDay? newTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          const TimeOfDay(hour: 12, minute: 00),
                                    );

                                    final time =
                                        '${newTime!.hour} : ${newTime.minute}';
                                    openTime.value = time;
                                  },
                                  child: Container(
                                    width: Get.width / 3,
                                    height: Get.height / 17,
                                    decoration: BoxDecoration(
                                        color: constants.inputBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: constants.inputStrokeColor)),
                                    child: Center(
                                      child: Text(
                                        openTime.toString(),
                                        style: TextStyle(
                                            color: constants.inputHintTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Close Time',
                                  style: TextStyle(
                                      color: constants.whiteTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(height: Get.height / 60),
                                InkWell(
                                  onTap: () async {
                                    final TimeOfDay? newTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          const TimeOfDay(hour: 12, minute: 00),
                                    );

                                    final time =
                                        '${newTime!.hour} : ${newTime.minute}';
                                    closeTime.value = time;
                                  },
                                  child: Container(
                                    width: Get.width / 3,
                                    height: Get.height / 17,
                                    decoration: BoxDecoration(
                                        color: constants.inputBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: constants.inputStrokeColor)),
                                    child: Center(
                                      child: Text(
                                        closeTime.toString(),
                                        style: TextStyle(
                                            color: constants.inputHintTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),

                  SizedBox(height: Get.height / 30),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomButton(
                            constants: constants,
                            title: 'Submit',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _submitForm();
                              }
                            },
                            width: Get.width / 4,
                            height: Get.height / 18),
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
}
