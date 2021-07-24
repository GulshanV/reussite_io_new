import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/add_reservation_controller.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/widget/button.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/input.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';
import 'package:reussite_io_new/widget/tools.dart';

class AddNewReservation extends GetView<AddReservationController>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PsColors.white,
      body: Column(
        children: [
          ToolsBar(),
          Expanded(

            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 0,left: 25,right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [



                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      'add_reservation'.tr,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 33,
                          color: PsColors.mainColor
                      ),
                    ),


                    const SizedBox(
                      height: 30,
                    ),

                    Row(
                      children: [
                        Text(
                          'select_child'.tr,
                          style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: PsColors.black
                          ),
                        ),
                        Expanded(child: const SizedBox()),
                        InkWell(
                          onTap: (){
                            Get.offNamedUntil(Routes.ADD_NEW_CHILD, (route) => true);
                          },
                          child: Text(
                            'add_child'.tr,
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: PsColors.mainColor
                            ),
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [

                        Container(
                          height: 80,
                          width: 80,
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
                        ),

                        InkWell(
                          onTap: (){
                            Get.toNamed(Routes.EDIT_CHILD);
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            margin: const EdgeInsets.only(
                                right: 10
                            ),
                            decoration: BoxDecoration(
                                color: PsColors.light_grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                                'assets/images/placeholder_girl.png'
                            ),
                          ),
                        ),


                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SelectionDropdown(
                      hint: 'subject'.tr,
                      onTap: (){

                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectionDropdown(
                      hint: 'date_time'.tr,
                      onTap: (){
                        Get.offNamedUntil(Routes.RESERVATION_DATETIME, (route) => true);
                      },
                    ),

                    const SizedBox(
                      height: 30,
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
                             hintText: 'assistance_description'.tr,
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
                        maxLines: 5,
                        minLines: 5,

                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RaisedGradientButtonGreen(
                        margin: const EdgeInsets.all(0),
                        onPressed: (){
                          // Get.offNamedUntil(Routes.HOME, (route) => true);

                        },
                        width: 150,
                        child:    Text(
                          'create'.tr.toUpperCase(),
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: PsColors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
}