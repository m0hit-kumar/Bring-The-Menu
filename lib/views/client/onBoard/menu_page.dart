import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/widgets/menu_card.dart';
import 'package:bring_the_menu/views/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slidable_button/slidable_button.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({super.key, required this.documentId});
  final String documentId;

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  final constants = Get.put(Constants());
  String docID = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      docID = widget.documentId.substring(1);
    });
  }

  void p() {
    print("------------- ${widget.documentId}");
  }

  int initialValue = 0;
  List<int> _quantities = [];

  void addQuantity(int index, int quantity) {
    setState(() {
      _quantities[index] = quantity;
    });
  }

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
          title: Text(
            "hi $docID",
            // "Bring The Menu",
            style: const TextStyle(fontSize: 13),
          ),
          backgroundColor: Colors.transparent,
          leading: TextButton(
              onPressed: () {},
              child: Icon(
                Icons.menu,
                color: constants.whiteTextColor,
              )),
          bottom: PreferredSize(
            preferredSize: const Size(50, 40),
            child: Column(
              children: [
                Text(
                  "The Restaurant",
                  style: TextStyle(
                      fontSize: 22,
                      color: constants.whiteTextColor,
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  height: 5,
                  color: constants.themeColor,
                ),
              ],
            ),
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(100, (index) {
            _quantities.add(0);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: MenuCard(
                    index: index,
                    onQuantityChanged: addQuantity,
                    rating: 4,
                    dishName: 'Chicken Biriyani',
                    isVeg: false,
                    price: 250,
                    initQty: 0),
              ),
            );
          }),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: constants.menuCardColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 50.0,
                      spreadRadius: 1,
                      offset: Offset(
                        0.2,
                        0.2,
                      ),
                    )
                  ],
                ),
                child: HorizontalSlidableButton(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 60.0,
                  buttonWidth: MediaQuery.of(context).size.width / 2,
                  color: constants.menuCardColor,
                  buttonColor: constants.themeColor,
                  dismissible: false,
                  label: Center(
                      child: Text(
                    'Order',
                    style: TextStyle(
                        color: constants.whiteTextColor, fontSize: 22),
                  )),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Text(
                        'Swipe >>',
                        style: TextStyle(
                            color: constants.whiteTextColor, fontSize: 22),
                      ),
                    ),
                  ),
                  onChanged: (position) {
                    setState(
                      () {
                        if (position == SlidableButtonPosition.end) {
                          print("sliding");
                          print("Quantities: $_quantities");
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
