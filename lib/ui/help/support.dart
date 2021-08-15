import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';
import 'package:reussite_io_new/widget/mobile_widget.dart';
import 'package:share/share.dart';

class SupportPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PsColors.mainColor,

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/dot_bg.png',
                ),
                fit: BoxFit.fill
            )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45,left: 15,right: 15,bottom: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: ()=>Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: PsColors.white,
                    ),
                  ),
                  Expanded(child:const SizedBox()),


                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.only(top: 20,bottom: 20),
                      decoration: BoxDecoration(
                        color: PsColors.light_green,
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'student_support'.tr,
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 33,
                                color: PsColors.white
                            ),
                            textAlign: TextAlign.center,
                          ),

                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Lukas_app'.tr,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: PsColors.white
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socail(
                          'assets/images/twitter.png'
                        ),
                        socail(
                          'assets/images/facebook.png'
                        ),
                        socail(
                          'assets/images/instagram.png'
                        ),


                      ],
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    InkWell(
                      onTap: (){
                        Share.share('check out my website https://example.com');
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 50,
                          right: 50,
                          top: 13,
                          bottom: 13
                        ),
                        decoration: BoxDecoration(
                          color: PsColors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Text(
                          'share_app'.tr,
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w500,
                            color: PsColors.black,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap:(){
                        Get.offNamedUntil(Routes.SUPPORT_REQUEST, (route) => true);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 59,
                            right: 59,
                            top: 13,
                            bottom: 13
                        ),
                        decoration: BoxDecoration(
                            color: PsColors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:Text(
                          'support'.tr,
                          style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w500,
                              color: PsColors.black,
                              fontSize: 18
                          ),
                        ),
                      ),
                    )


                  ],
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '2021 - v.2.1',
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: PsColors.white
                ),
                textAlign: TextAlign.center,
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget socail(String image){

    return Container(
      height: 46,
      width: 46,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: PsColors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        image,
        color: PsColors.mainColor,
      ),
    );
  }
}