import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';
import 'package:reussite_io_new/widget/input.dart';

class AddNameandProfilePicture extends GetView<AuthController>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PsColors.mainColor,

      body: Container(
        margin: const EdgeInsets.only(top: 150,left: 25,right: 25),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/dot_bg.png',
                ),
                fit: BoxFit.fill
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text(
                'let_get_acquanted'.tr,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                    color: PsColors.white
                ),
              ),


              const SizedBox(
                height: 55,
              ),

              Row(
                children: [

                  Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.only(
                      right: 10
                    ),
                    decoration: BoxDecoration(
                      color: PsColors.light_green,
                      borderRadius: BorderRadius.circular(7)
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/icons/profile_pic_icon.png'
                    ),
                  ),

                  Text(
                    'add_an_avater'.tr,
                    style: GoogleFonts.notoSans(
                      color: PsColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                  )

                ],
              ),
              const SizedBox(
                height: 30,
              ),


              InputWidget(
                margin: const EdgeInsets.all(0),
                hint: 'full_name'.tr,
                onChange: (v){},
              ),



              const SizedBox(
                height: 30,
              ),


              Align(
                alignment: Alignment.topLeft,
                child: RaisedGradientButton(
                  margin: const EdgeInsets.all(0),
                  onPressed: (){
                    Get.offNamedUntil(Routes.HOME, (route) => true);
                  },
                  width: 150,
                  child:    Text(
                    'next'.tr.toUpperCase(),
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: PsColors.black
                    ),
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