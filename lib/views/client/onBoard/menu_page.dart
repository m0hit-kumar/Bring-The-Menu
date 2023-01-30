import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/widgets/menu_card.dart';
import 'package:bring_the_menu/views/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Quantities: $_quantities");
        },
      ),
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
    );
  }
}

class TrianglePainter extends CustomPainter {
  TrianglePainter({required this.veg});
  final Color veg;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = veg
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height / 4.5);
    path.lineTo(size.width / 1.5, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
