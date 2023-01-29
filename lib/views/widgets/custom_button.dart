import 'package:bring_the_menu/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.constants,
    required this.title,
    required this.onTap,
    required this.width,
    required this.height,
  });

  final Constants constants;
  String title;
  double width;
  double height;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: constants.themeColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(title,
              style: TextStyle(color: constants.whiteTextColor, fontSize: 18)),
        ),
      ),
    );
  }
}
