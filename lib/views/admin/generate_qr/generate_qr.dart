import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenerateQRCodes extends StatefulWidget {
  const GenerateQRCodes({super.key});

  @override
  State<GenerateQRCodes> createState() => _GenerateQRCodesState();
}

class _GenerateQRCodesState extends State<GenerateQRCodes> {
  final constants = Get.put(Constants());
  TextEditingController totalSeatsController = TextEditingController();
  bool showQrCodes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: Get.width / 30, right: Get.width / 30, top: Get.width / 15),
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
              'Total Seats',
              style: TextStyle(
                  color: constants.whiteTextColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: Get.height / 30),
            InputWidget(
                constants: constants,
                title: '',
                hintText: 'eg: 10',
                controller: totalSeatsController,
                isObscrue: false),
            SizedBox(height: Get.height / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    constants: constants,
                    title: 'Generate',
                    onTap: () {},
                    width: Get.width / 4,
                    height: Get.height / 20),
              ],
            ),
            SizedBox(height: Get.height / 30),
            QRCodeContainer(
              constants: constants,
              seatNo: 'Seat No',
              downloadText: 'QR Code Link',
            ),
            // ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (context, index) {
            //       return QRCodeContainer(
            //           constants: constants,
            //           seatNo: index.toString(),
            //           downloadText: 'Download QR');
            //     }),
          ],
        ),
      ),
    );
  }
}

class QRCodeContainer extends StatelessWidget {
  QRCodeContainer(
      {super.key,
      required this.constants,
      required this.seatNo,
      required this.downloadText});

  final Constants constants;
  String seatNo;
  String downloadText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
      child: Container(
        width: double.infinity,
        height: Get.height / 20,
        decoration: BoxDecoration(
            border: Border.all(color: constants.inputStrokeColor)),
        child: Row(
          children: [
            Container(
              width: Get.width / 4,
              height: Get.height / 20,
              decoration: BoxDecoration(
                  border: Border.all(color: constants.inputStrokeColor)),
              child: Center(
                child: Text(
                  seatNo,
                  style:
                      TextStyle(color: constants.whiteTextColor, fontSize: 18),
                ),
              ),
            ),
            Container(
              width: Get.width / 1.831,
              height: Get.height / 20,
              decoration: BoxDecoration(
                  border: Border.all(color: constants.inputStrokeColor)),
              child: Center(
                child: Text(
                  downloadText,
                  style:
                      TextStyle(color: constants.whiteTextColor, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
