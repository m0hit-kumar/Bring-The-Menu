import 'package:bring_the_menu/constants.dart';
import 'package:bring_the_menu/views/utility_classes/mytheme.dart';
import 'package:bring_the_menu/views/widgets/custom_button.dart';
import 'package:bring_the_menu/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

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
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: EdgeInsets.only(
              left: Get.width / 30, right: Get.width / 30, top: Get.width / 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                    textAlign: TextAlign.center,
                  'Bring The Menu',
                  style: TextStyle(
                      color: MyTheme.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      fontStyle: FontStyle.normal,
                      wordSpacing: 0.0),
                ),
              ),
              SizedBox(height: Get.height / 70),
              Text(
                'Total Seats',
                style: TextStyle(
                    color: constants.whiteTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ).centered(),
             
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
                      onTap: () {
                        // Implement Logic to save qr data to db
                        setState(() {
                          showQrCodes = true;
                        });
                      },
                      width: Get.width / 3,
                      height: Get.height / 20),
                ],
              ),
              SizedBox(height: Get.height / 30),
              QRCodeContainer(
                constants: constants,
                seatNo: 'Seat No',
                downloadText: 'QR Code Link',
              ),
              showQrCodes
                  ? ListView.builder(
                      itemCount: int.parse(totalSeatsController.text),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return QRCodeContainer(
                          constants: constants,
                          seatNo: index.toString(),
                          downloadText: 'Download Link',
                          downloadLink:
                              'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=google.com',
                        );
                      })
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class QRCodeContainer extends StatelessWidget {
  QRCodeContainer({
    super.key,
    required this.constants,
    required this.seatNo,
    required this.downloadText,
    this.downloadLink,
  });

  final Constants constants;
  String seatNo;
  String downloadText;
  String? downloadLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
      child: Container(
        width: double.maxFinite,
        height: Get.height / 20,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent)),
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
              width: Get.width/1.9,
              height: Get.height / 20,
              decoration: BoxDecoration(
                  border: Border.all(color: constants.inputStrokeColor)),
              child: InkWell(
                onTap: () async {
                  // Implement download login using URL Launcher.
                  final Uri url = Uri.parse(downloadLink!);

                  if (!await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: Center(
                  child: Text(
                    downloadText,
                    style: TextStyle(
                        color: MyTheme.darkBlue, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
