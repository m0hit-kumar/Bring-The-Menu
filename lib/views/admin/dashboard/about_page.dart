import "package:bring_the_menu/constants.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final constants = Get.put(Constants());

  Map<String, dynamic> info = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<DocumentSnapshot<Map<String, dynamic>>> aboutRestaurant =
    //     FirebaseFirestore.instance
    //         .collection('restaurants')
    //         .doc("SqNrahYI1KhQaVZXzkcN")
    //         .get();

    // aboutRestaurant.asStream().listen((snap) {
    //   if (snap.exists) {
    //     Map<String, dynamic>? data = snap.data();
    //     print(data!["name"]);
    //     setState(() {
    //       info = data;
    //     });
    //   }
    // });

    // print("000 $info");
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("restaurants")
            .doc("SqNrahYI1KhQaVZXzkcN")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;

            print(data);
          }
          return Scaffold(
              backgroundColor: constants.backgroundColor,
              body: Padding(
                padding: const EdgeInsets.only(
                    bottom: 18.0, top: 80.0, left: 18.0, right: 18.0),
                child: Container(
                  color: Colors.red,
                  child: Column(children: [Text("fjoweijfo"), Text("fjwepjf")]),
                ),
              ));
        });
  }
}
