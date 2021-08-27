import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget{
  @override
  _Splash createState()=>_Splash();
}

class _Splash extends State<Splash>{


  @override
  void initState() {
    super.initState();

    timer();
  }

  timer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response= prefs.getString('login');

    if(response!=null && response!=''){
      var js=json.decode(response);
      var user = AuthModel.fromJson(js);
      Timer(Duration(seconds: 3), (){
        if(user.firstName==null){
          // Get.offAndToNamed(Routes.ADD_NAME_PIC_LOGIN);
          Get.offNamedUntil(Routes.ADD_NAME_PIC_LOGIN, (route) => true);
        }else{
          Get.offNamedUntil(Routes.HOME, (route) => true);
        }

      });
    }else{

      Timer(Duration(seconds: 3), (){
        Get.offNamedUntil(Routes.WELCOME, (route) => true);
      });

    }


  }

  //(647) 8475602


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
            fit: BoxFit.fill
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              height: 80,
              width: 80,
              margin:  EdgeInsets.only(bottom: 25, top: 50),
              decoration: BoxDecoration(
                color: PsColors.white,
                borderRadius: BorderRadius.circular(15)
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/images/logo.png'),
            ),

            Text(
                'student_support'.tr.toUpperCase(),
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 33,
                  color: PsColors.white
                ),
            ),

            const SizedBox(
              height: 10,
            ),
            Text(
                'for_school_success'.tr,
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: PsColors.white
                ),
            )

          ],
        ),
      ),
    );
  }
}