import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';
import 'package:reussite_io_new/widget/mobile_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final AuthController controller = Get.put(AuthController());

  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsColors.mainColor,
      body: Container(
        margin: const EdgeInsets.only(top: 150, left: 25, right: 25),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/dot_bg.png',
                ),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'mobile_number'.tr,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                    color: PsColors.white),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'enter_phone_no'.tr,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: PsColors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              MobileWidget(
                phoneNumberController: phoneNumberController,
              ),
              const SizedBox(
                height: 25,
              ),
              Text.rich(TextSpan(
                  text: 'you_agree_to_our'.tr,
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: PsColors.white),
                  children: [
                    TextSpan(
                      text: 'terms_conditions'.tr,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: PsColors.white,
                          decoration: TextDecoration.underline),
                    )
                  ])),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: RaisedGradientButton(
                  margin: const EdgeInsets.all(0),
                  onPressed: () async {
                    if (phoneNumberController.text.length < 9) {
                      Get.defaultDialog(
                          title: "invalid!", middleText: 'invalid_mobile_no');
                    } else {
                      Get.toNamed(Routes.OTP_VERIFY_nav);
                      // String error = await controller.login(
                      //     phone: phoneNumberController.text
                      // );
                      // if(error != "") {
                      //   Get.defaultDialog(title: "Oop!", middleText: error);
                      //   } else {
                      //     Get.toNamed(Routes.OTP_VERIFY_nav);
                      //  }
                    }
                  },
                  width: 175,
                  child: Text(
                    'send_code'.tr.toUpperCase(),
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: PsColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
