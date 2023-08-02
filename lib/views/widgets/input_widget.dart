import 'package:bring_the_menu/views/utility_classes/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bring_the_menu/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class InputWidget extends StatelessWidget {
  InputWidget(
      {Key? key,
      required this.constants,
      required this.title,
      required this.hintText,
      required this.controller,
      this.textInputType,
      required this.isObscrue})
      : super(key: key);



  final Constants constants;
  String title;
  String hintText;
  TextEditingController controller;
  final TextInputType? keyboardType;
  bool isObscrue;
  TextInputType? textInputType;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool get isPassword => TextInputType.visiblePassword == widget.keyboardType;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: MyTheme.darkBlue,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: Get.height / 300),
            Container(
              width: double.infinity,
              height: Get.height / 17,
              decoration: BoxDecoration(
                  color: widget.constants.inputBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: widget.constants.inputStrokeColor)),
              child: TextFormField(

                controller: controller,
                keyboardType: textInputType ?? TextInputType.text,

                obscureText: isPassword ? widget.isObscrue : false,

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontStyle: context.captionStyle!.fontStyle,
                      color: widget.constants.inputHintTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
