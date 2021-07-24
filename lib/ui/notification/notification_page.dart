import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';
import 'package:reussite_io_new/widget/mobile_widget.dart';

import 'notification_view.dart';

class NotificationPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PsColors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60,left: 15,right: 15,bottom: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: PsColors.mainColor,
                  ),
                ),
                Expanded(child:const SizedBox()),


              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'notification'.tr,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                          color: PsColors.mainColor
                      ),
                      textAlign: TextAlign.center,
                    ),


                    const SizedBox(
                      height: 30,
                    ),

                    Wrap(
                      children: [
                        1,2,3,4,5
                      ].map((e) => NotificationView()).toList()
                    )



                  ],
                ),
              ),
            ),
          ),




        ],
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