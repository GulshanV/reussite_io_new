import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/ui/add_child/update_child_controller.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/input_with_level.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';

class EditChild extends StatefulWidget{
  EditChild();

  @override
  _EditChild createState()=>_EditChild();
}

class _EditChild extends State<EditChild>{

  final  controller = Get.put(UpdateChildController());

  String fullName='';
  String school='';
  String board='';
  String phone='';
  String email='';


  @override
  void initState() {
    super.initState();
    controller.getChildInformation();
  }

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

                controller.isEdit.value?const SizedBox(
                  width: 30,
                ):InkWell(
                  onTap: (){
                    controller.edit();
                  },
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
            child: Obx(() => controller.isLoadInformation.value?Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ):SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text(
                        '${controller.student.value.firstName??''}\n${controller.student.value.lastName??''}',
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
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Expanded(child:  Text(
                        'meet.appui.io/${controller.student.value.conferenceUrl??''}',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: PsColors.meetLinkColor,
                            fontSize: 12,
                            decoration: TextDecoration.underline
                        ),
                      )),

                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            color: PsColors.mainColor,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                            'assets/images/link.png'
                        ),
                      )

                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  InputLevel(
                    enable: controller.isEdit.value,
                    controller: TextEditingController(text: controller.student.value.schoolName??''),
                    margin: const EdgeInsets.all(0),
                    hint: 'school_name'.tr,
                    onChange: (v){
                      fullName=v;
                    },
                  ),


                   SizedBox(
                    height: controller.isEdit.value?15:0,
                  ),
                  InputLevel(
                    enable: controller.isEdit.value,
                    controller: TextEditingController(text: controller.student.value.schoolName??''),
                    margin: const EdgeInsets.all(0),
                    hint: 'school_name'.tr,
                    onChange: (v){
                      fullName=v;
                    },
                  ),


                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    enable: controller.isEdit.value,
                    controller: TextEditingController(text: controller.student.value.schoolBoard??''),
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
                    levelValue: controller.student.value.grade??'',
                    onTap: (){

                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    enable: controller.isEdit.value,
                    margin: const EdgeInsets.all(0),
                    hint: 'phone_number'.tr,
                    onChange: (v){
                      phone=v;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputLevel(
                    enable: controller.isEdit.value,
                    controller: TextEditingController(text: controller.student.value.email??''),
                    margin: const EdgeInsets.all(0),
                    hint: 'email'.tr,
                    onChange: (v){
                      email=v;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap:(){
                        Navigator.pop(context,1);
                      },
                      child: Text(
                        'remove_child'.tr,
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600,
                            color: PsColors.hintColor,
                            fontSize: 14
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                ],
              ),
            )),
          ),)
        ],
      ),
    );
  }
}