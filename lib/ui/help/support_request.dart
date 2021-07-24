import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/input_with_level.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';

class SupportRequest extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PsColors.white,
      body: Column(
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
          Expanded(child:  Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    'support'.tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: PsColors.mainColor
                    ),
                  ),

                  const SizedBox(height: 100,),
                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'email'.tr,
                    onChange: (v){},
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: PsColors.borderlineColor,
                            width: 0.5
                        )
                    ),
                    child: TextField(
                      onChanged: (v){

                      },
                      decoration: InputDecoration(
                          border:  InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 20,right: 0,top: 15,bottom: 15),
                          hintText: 'message'.tr,
                          hintStyle:TextStyle(
                              fontWeight: FontWeight.w600,
                              color: PsColors.hintColor,
                              fontStyle: FontStyle.normal,
                              fontSize: 15
                          ),
                          counterText: ""
                      ),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: PsColors.black,
                          fontSize: 16
                      ),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      maxLines: 10,
                      minLines: 8,

                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RaisedGradientButtonGreen(
                      margin: const EdgeInsets.all(0),
                      onPressed: (){
                        // Get.offNamedUntil(Routes.HOME, (route) => true);

                      },
                      isValid: false,
                      width: 150,
                      child:    Text(
                        'send'.tr.toUpperCase(),
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: PsColors.hintColor
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )

                ],
              )
            ),
          ),)
        ],
      ),
    );
  }

  Widget getView(String image,String title){

    return Container(
      margin: const EdgeInsets.only(top: 20,bottom: 20),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 80,
          ),
          const SizedBox(
            width: 20,
          ),

          Expanded(
            child:Text(
              title,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                color: PsColors.dark_textcolor,
                fontSize: 16
              ),
              textAlign: TextAlign.left,
            ) ,
          ),

          Icon(
            Icons.keyboard_arrow_right_sharp,
            size: 20,
            color: PsColors.mainColor,
          )
        ],
      ),
    );

  }
}