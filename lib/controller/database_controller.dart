import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  static get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  CollectionReference users =
      FirebaseFirestore.instance.collection('restaurants');
  Future<void> createProfile(
      String restaurantName,
      String location,
      String phone,
      String website,
      String upiController,
      String openTime,
      String closeTime) async {
    final user = _auth.currentUser?.uid;
    print("000000000000000000 $user");

    final createProfile = {
      'name': restaurantName == "" ? "Bring the menu" : restaurantName,
      'contact': phone == "" ? "9876543210" : phone,
      "website": website == "" ? "Bringthemenu.com" : website,
      "timming": {
        "openTime": openTime == "" ? "8:00 am" : openTime,
        "closeTime": closeTime == "" ? "8:00 pm" : closeTime
      },
      "upi": "9876543210@upi",
      "type": "veg",
      // "loc": const GeoPoint(30.2829736, 76.7105632),
      //added location
      "loc": location==""?"Not Selected":location,
      "images":
          "https://lh5.googleusercontent.com/g69fW72YegaMsGMEa-qIxrRskVXhSIM3UfEP4xqit6T2aVBQSbA0zcQsl40MftwvPw2rac37x2SX_7pt06h9t7SXZB_i81qpCJIgsKo_gn74jMBj65QxY7ZbCsIda90o14dFyS2g"
    };

    users.doc(user).set(createProfile).then((value)
        // ignore: avoid_print
        {
      print("000000000000 Profile Created");
      Get.toNamed("/adminDashboard");
    }).catchError(
        // ignore: avoid_print, invalid_return_type_for_catch_error
        (error) {
      print("000000000000 Failed to Create user: $error");
    });
  }

  Future<bool> profileAvailable() async {
    final user = _auth.currentUser?.uid;
    print("000000000000000000 $user");

    _db
        .collection('restaurants')
        .doc(user)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    });
    return false;
  }
}
