import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/input_with_level.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';

class EditChild extends StatelessWidget{

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

                InkWell(
                  onTap: (){},
                  child: Icon(
                    Icons.edit,
                    size: 30,
                    color: PsColors.mainColor,
                  ),
                )
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

                 Row(
                   children: [
                     Text(
                       'Rayna\nStanton',
                       style: GoogleFonts.notoSans(
                           fontWeight: FontWeight.bold,
                           fontSize: 33,
                           color: PsColors.mainColor
                       ),
                     ),

                     Expanded(child: const SizedBox()),
                     Container(
                       height: 60,
                       width: 60,
                       margin: const EdgeInsets.only(
                           right: 10
                       ),
                       decoration: BoxDecoration(
                           color: PsColors.light_grey,
                           borderRadius: BorderRadius.circular(10)
                       ),
                       child: Image.asset(
                           'assets/dummy/squircle.png'
                       ),
                     )

                   ],
                 ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'meet.appui.io/rayna-maldrene',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: PsColors.meetLinkColor,
                      fontSize: 12
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),



                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'school_name'.tr,
                    onChange: (v){},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'school_board'.tr,
                    onChange: (v){},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectionDropdown(
                    hint: 'level_of_study'.tr,
                    onTap: (){

                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'phone_number'.tr,
                    onChange: (v){},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'email'.tr,
                    onChange: (v){},
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  SelectionDropdown(
                    hint: 'remove_child'.tr,
                    onTap: (){

                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),


                ],
              ),
            ),
          ),)
        ],
      ),
    );
  }
}