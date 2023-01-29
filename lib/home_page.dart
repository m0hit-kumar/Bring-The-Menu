import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('menu').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(5.0)),
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Search'),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: const Color(0xFFE9E9E9),
                padding: const EdgeInsets.only(left: 2.0, right: 0.0),
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 233, 228, 228),
                              blurRadius: 0.0,
                              spreadRadius: 0.1,
                            )
                          ],
                          color: Color(0xFFF5F5F5),
                          // border: Border.all(
                          //   width: 5,
                          //   color: Colors.deepPurpleAccent,
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: CircleAvatar(
                                    // backgroundImage:
                                    //     NetworkImage(data["imageURL"]),
                                    radius: 40,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data['name']),
                                      Text("${data['rate']}"),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor:
                                        data["veg"] ? Colors.green : Colors.red,
                                  ),
                                )
                              ]),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
