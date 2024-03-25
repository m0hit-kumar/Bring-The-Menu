import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/controller/database_controller.dart';
import 'package:bring_the_menu/views/admin/dashboard/admin_dashboard.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AdminCompleteProfile extends StatefulWidget {
  const AdminCompleteProfile({super.key});

  @override
  State<AdminCompleteProfile> createState() => _AdminCompleteProfileState();
}

class _AdminCompleteProfileState extends State<AdminCompleteProfile> {
  final DatabaseController _dbController = Get.find();
  final constants = Get.put(Constants());
  final db = Get.put(DatabaseController());
  TextEditingController restaurantNameController = TextEditingController();

  TextEditingController restaurantLocationController = TextEditingController();


  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  RxString openTime = 'Select Time'.obs;
  RxString closeTime = 'Select Time'.obs;
GeoPoint? _currentPoint;

  //handling the location permission
  Future<bool> _handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return true;
  }

  //getting the pincode from the current location
  Future<void> getPincode(Position position)async{
    await placemarkFromCoordinates(position.latitude, position.longitude)
          .then((List<Placemark> placemarks) async {
        Placemark place = placemarks[0];
        String pin = place.postalCode.toString();
        setState(() {
          restaurantLocationController.text = pin;
        });
      }, onError: (e) {
        print(e);
      });
  }

  //getting the current location using GPS with geoLocator
  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPoint = GeoPoint(position.latitude, position.longitude);
      });
      await getPincode(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> menuRef = FirebaseFirestore
      .instance
      .collection('restaurants')
      .doc("SqNrahYI1KhQaVZXzkcN")
      .get();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
     getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();

    fetchRestaurantData();
  }

  Future<void> fetchRestaurantData() async {
    final user = _dbController.auth.currentUser?.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(user)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;

      restaurantNameController.text = data['name'] ?? '';
        // locationController.text = data['location'] ?? '';
      phoneController.text = data['contact'] ?? '';
      websiteController.text = data['website'] ?? '';
       upiController.text = data['upi'] ?? '';
      openTime.value = data['timming']['openTime'] ?? 'Select Time';
      closeTime.value = data['timming']['closeTime'] ?? 'Select Time';
    }
  }

@override
  void dispose() {
    // Dispose of controllers
    restaurantNameController.dispose();
    restaurantLocationController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    upiController.dispose();

    // Dispose of RxString
    openTime.close();
    closeTime.close();
    _currentPoint = null;

    super.dispose();
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
                    title: 'Location Pincode',
                    hintText: 'Fetching.....',
                    controller: locationController,

                    isObscrue: false),

                SizedBox(height: Get.height / 30),

                // Phone & Website
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 1.95,
                      child: InputWidget(
                          textInputType: TextInputType.phone,
                          constants: constants,
                          title: 'Phone',
                          hintText: 'eg: 8813900000',
                          controller: phoneController,
                          isObscrue: false),
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
                    )
                  ],
                ),

                // UPI
                SizedBox(height: Get.height / 30),
                InputWidget(
                    constants: constants,
                    title: 'UPI',
                    hintText: 'eg: 8813@paytm',
                    controller: upiController,
                    isObscrue: false),

                // Opening Closing
                SizedBox(height: Get.height / 30),
                Obx(() => Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
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
                            print("000000000000 submit");
                            try {
                              db.createProfile(
                                  restaurantNameController.text,
                                  _currentPoint!,
                                  phoneController.text,
                                  websiteController.text,
                                  upiController.text,
                                  openTime.string,
                                  closeTime.string);
                            } catch (e) {
                              print(e);
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
      );
    }
  }
}
