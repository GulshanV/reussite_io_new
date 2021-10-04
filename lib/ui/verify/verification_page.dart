import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/model/auth_model.dart';
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
    getUser();
    super.initState();
    startTimer();
  }
  AuthModel auth;
  getUser(){
    var res = Get.arguments['data'];
    print(res);
    var js=json.decode(res);
    auth=AuthModel.fromJson(js);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: controller.otpInvalid.value
              ? PsColors.markColor
              : PsColors.mainColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Icon(
                      Icons.arrow_back,
                      color: PsColors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50, left: 25, right: 25),
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
                          fontSize: 34,
                          color: PsColors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        auth==null?'':'verification_msg'.tr.replaceAll('+18634223910', '+${auth.phoneNumber}'),
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
                        padding: const EdgeInsets.only(left: 0, right: 0),
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
                            ):const SizedBox(),

                      const SizedBox(
                        height: 20,
                      ),

                      _start == 0?Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap:(){
                            controller.resendOTP();
                            _start = 60;
                            startTimer();
                          },
                          child: Text(
                              'resend_code'.tr,
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: PsColors.white)
                          ),
                        ),
                      ): Align(
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
                        child: controller.loginProcess.value?Center(
                          child: CircularProgressIndicator(),
                        ):RaisedGradientButton(
                          margin: const EdgeInsets.all(0),
                          onPressed: () async {
                            var value = await controller.otpValid(textEditingController.text);
                            if (value == null) {

                            } else {
                              setState(() {
                                error = value;
                              });
                            }
                          },
                          width: 180,
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
            ],
          ),
        ));
  }
}
