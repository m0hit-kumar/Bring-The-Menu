import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuCard extends StatefulWidget {
  final String dishName;
  final int rating;
  final int price;
  final String orderedDishName;
  final bool isVeg;
  dynamic Function(String, int) onQuantityChanged;
  final int initQty;
  final double width;
  final double height;
  final double textScaleFactor;

  MenuCard({
    super.key,
    required this.dishName,
    required this.rating,
    required this.price,
    required this.isVeg,
    required this.initQty,
    required this.orderedDishName,
    required this.onQuantityChanged,
    required this.width,
    required this.height,
    required this.textScaleFactor,
  });
  @override
  // State<MenuCard> createState() => _MenuCardState();

  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  final constants = Get.put(Constants());
  int _quantity = 0;
  @override
  void initState() {
    _quantity = widget.initQty;
    super.initState();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
    // print("vale $_quantity");

    widget.onQuantityChanged(widget.orderedDishName, _quantity);
  }

  void _decrementQuantity() {
    setState(() {
      _quantity--;
    });
    widget.onQuantityChanged(widget.orderedDishName, _quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
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
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: Container(
            alignment: Alignment.center,
            color: constants.menuCardColor,
            child: CustomPaint(
              painter: TrianglePainter(
                  veg: widget.isVeg ? Colors.green : Colors.red),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dishName.replaceAll(' ', '\n'),
                          style: TextStyle(
                              color: constants.whiteTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        StarRating(
                          rating: widget.rating,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Rs ${widget.price} ",
                          style: TextStyle(
                              color: constants.whiteTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              color: Color.fromARGB(255, 245, 229, 228),
                              icon: Icon(
                                size: 14,
                                Icons.remove,
                                color: constants.whiteTextColor,
                              ),
                              enableFeedback: true,
                              onPressed: _decrementQuantity,
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                  top: 2.0,
                                  bottom: 2.0,
                                  left: 2.5,
                                  right: 2.5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: constants.whiteTextColor,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Text(
                                  _quantity.toString(),
                                  style: TextStyle(
                                      color: constants.whiteTextColor),
                                )),
                            IconButton(
                                icon: Icon(
                                  size: 14,
                                  Icons.add,
                                  color: constants.whiteTextColor,
                                ),
                                enableFeedback: true,
                                onPressed: _incrementQuantity),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
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
