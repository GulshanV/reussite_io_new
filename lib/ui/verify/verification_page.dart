import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPage createState() => _VerificationPage();
}

class _VerificationPage extends State<VerificationPage> {
  final AuthController controller = Get.put(AuthController());
  TextEditingController textEditingController = TextEditingController();

  String error;

  Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: controller.otpInvalid.value
              ? PsColors.markColor
              : PsColors.mainColor,
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
                    'verification'.tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                        color: PsColors.white),
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    'verification_msg'.tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: PsColors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      obscureText: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        inactiveColor: Colors.white,
                        selectedColor: Colors.transparent,
                        inactiveFillColor: Colors.transparent,
                        activeColor: Colors.transparent,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      // backgroundColor: Colors.white,
                      enableActiveFill: true,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  error != null
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/error_shape.png',
                                width: 13,
                                height: 13,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(error ?? '',
                                  style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: PsColors.white)),
                            ],
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Text.rich(TextSpan(
                              text: 'resend_code'.tr,
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: PsColors.white),
                              children: [
                                TextSpan(
                                  text: " ${_start.toString()}" ?? "",
                                  style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: PsColors.white,
                                  ),
                                )
                              ])),
                        ),

                  const SizedBox(
                    height: 50,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: RaisedGradientButton(
                      margin: const EdgeInsets.all(0),
                      onPressed: () {
                        var value =
                            controller.otpValid(textEditingController.text);
                        if (value == null) {
                          Get.offNamedUntil(
                              Routes.ADD_NAME_PIC_LOGIN, (route) => true);
                        } else {
                          setState(() {
                            error = value;
                          });
                        }
                      },
                      width: 175,
                      child: Text(
                        'submit'.tr.toUpperCase(),
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
        ));
  }
}
