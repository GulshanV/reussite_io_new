import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/input_with_level.dart';
import 'package:reussite_io_new/widget/mobile_widget.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';

class AddNewChild extends StatefulWidget{

  @override
  _AddNewChild createState()=>_AddNewChild();
}

class _AddNewChild extends State<AddNewChild>{
  final AuthController controller = Get.put(AuthController());

  String fullName='';
  String school='';
  String board='';
  String phone='';
  String email='';

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

                  Text(
                    'add_you_child'.tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                        color: PsColors.mainColor
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
                        'add_child_avater'.tr,
                        style: GoogleFonts.notoSans(
                            color: PsColors.toolTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                        ),
                      )

                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'full_name'.tr,
                    onChange: (v){
                      fullName=v;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'school_name'.tr,
                    onChange: (v){
                      school=v;
                      },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'school_board'.tr,
                    onChange: (v){
                      board=v;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectionDropdown(
                    hint: 'level_of_study'.tr,
                    onTap: (){
                     // school=v;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PsColors.white,
                        border: Border.all(
                            color: PsColors.borderlineColor,
                            width: 1
                        )
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(

                                inputFormatters: [const UpperCaseTextFormatter(),  MaskTextInputFormatter(mask: "(###) ###-##-##")],
                                autocorrect: false,
                                onChanged: (v){
                                  phone=v;
                                },
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    color: PsColors.black,
                                    fontSize: 16
                                ),
                                keyboardType: TextInputType.phone,
                                autovalidateMode: AutovalidateMode.always,
                                decoration: InputDecoration(
                                    hintText:'',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: PsColors.hintColor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border:InputBorder.none,
                                    errorMaxLines: 1
                                )
                            ),
                          ),
                          Text(
                            'phone_number'.tr,
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w500,
                                color: PsColors.hintColor,
                                fontSize: 10
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    margin: const EdgeInsets.all(0),
                    hint: 'email'.tr,
                    onChange: (v){
                       email=v;
                    },
                  ),

                 /* const SizedBox(
                    height: 30,
                  ),
                  SelectionDropdown(
                    hint: 'change_phone_no'.tr,
                    onTap: (){


                    },
                  ),*/
                  const SizedBox(
                    height: 30,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: RaisedGradientButtonGreen(
                      margin: const EdgeInsets.all(0),
                      onPressed: (){
                        controller.validationCreateStudent(
                        fullName,
                          school,
                          board,
                          '1',
                         phone,
                          email,
                        );
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