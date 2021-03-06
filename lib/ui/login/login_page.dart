import 'package:country_code_picker/country_code.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';
import 'package:reussite_io_new/widget/mobile_widget.dart';

import '../../utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final AuthController controller = Get.put(AuthController());

  CountryCode country = CountryCode(code: 'IO', dialCode: '+246');
  TextEditingController phoneNumberController = TextEditingController();
  String countryCode;

  @override
  void initState() {
    super.initState();
    getLocalCountry();
  }

  getLocalCountry() async {
    await CountryCodes.init(); // Optionally, you may provide a `Locale` to get countrie's localizadName

    final Locale deviceLocale = CountryCodes.getDeviceLocale();
    print(deviceLocale.languageCode); // Displays en
    print(deviceLocale.countryCode); // Displays US

    final CountryDetails details = CountryCodes.detailsForLocale();
    print(details.alpha2Code); // Displays alpha2Code, for example US.
    print(details.dialCode); // Displays the dial code, for example +1.
    print(details.name); // Displays the extended name, for example United States.
    print(details.localizedName);

    setState(() {
      country = CountryCode(code: details.alpha2Code, dialCode: '${details.dialCode}');
    });
    Utils.saveCountryCode(details.alpha2Code);
  }


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
                  countryCodeInitil:country.code,
                onTapCountry: (v) {
                  setState(() {
                    country = v;
                    Utils.saveCountryCode(v.code);
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Text.rich(
                TextSpan(
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
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Obx(() => Align(
                    alignment: Alignment.topLeft,
                    child: controller.loginProcess.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RaisedGradientButton(
                            margin: const EdgeInsets.all(0),
                            onPressed: () async {
                              if (phoneNumberController.text.length < 9) {
                                Get.defaultDialog(
                                    title: "invalid!",
                                    middleText: 'invalid_mobile_no'.tr);
                              } else {
                                String error = await controller.login(
                                    phone: phoneNumberController.text,
                                    dialCode: country.dialCode);

                                if (error == null) {
                                  Utils.errorMsg("Oop! something is wrong");
                                } else {
                                  var map = {'data': error};
                                  Get.offNamedUntil(
                                      Routes.OTP_VERIFY_nav, (route) => true,
                                      arguments: map);
                                }
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
