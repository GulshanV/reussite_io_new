import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';

class WelComePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: PsColors.mainColor,
      body: Container(
        width: w,
        margin: const EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/dot_bg.png',
                ),
                fit: BoxFit.fill)),
        child: Stack(
          children: [
            Positioned(
                top: 60,
                right: 25,
                child: Container(
                  height: 200,
                  child: Image.asset('assets/images/welcome.png'),
                )),
            Positioned(
              top: 70,
              right: 150,
              left: 35,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'im_so_glad'.tr,
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: PsColors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RaisedGradientButton(
                      margin: const EdgeInsets.all(0),
                      onPressed: () {
                        Get.offNamedUntil(Routes.LOGIN, (route) => true);
                      },
                      width: 180,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'lets_go'.tr.toUpperCase(),
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: PsColors.black),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
