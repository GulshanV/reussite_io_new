import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/add_reservation_controller.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/model/course_model.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/ui/selection/course_selection.dart';
import 'package:reussite_io_new/utils.dart';
import 'package:reussite_io_new/widget/button.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/child_view.dart';
import 'package:reussite_io_new/widget/input.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';
import 'package:reussite_io_new/widget/tools.dart';

class AddNewReservation extends StatefulWidget{
  @override
  _AddNewReservation createState()=>_AddNewReservation();
}

class _AddNewReservation extends State<AddNewReservation>{
  final AddReservationController controller = Get.put(AddReservationController());

  Course course;
  ScheduleModel scheduleModel;
  String description;

  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
      backgroundColor: PsColors.white,
      body: WillPopScope(
        onWillPop: () async {
          if(!controller.isBack.value){
            return true;
          }else{
            return false;
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45,left: 15,right: 15,bottom: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                       if(!controller.isBack.value){
                         Navigator.pop(context);
                       }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: PsColors.mainColor,
                    ),
                  ),
                  Expanded(child: Text(
                    '',
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w400,
                        color: PsColors.toolTitleColor,
                        fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                  )),

                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
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
                            onTap: () async {
                              var value = await Get.offNamedUntil(Routes.ADD_NEW_CHILD, (route) => true);
                              if(value!=null){

                              }
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

                      controller.childLoadProcess.value?Center(
                        child: CircularProgressIndicator(),
                      ):controller.childLoadProcess.value && controller.arrStudent.length==0?Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'not_child_found',
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w400,
                            color: PsColors.hintColor,
                            fontSize: 16
                          ),
                        ),
                      ):Wrap(
                        children: List.generate(controller.arrStudent.length, (index){

                            return  InkWell(
                              onTap: (){
                                controller.changeIndex(index);
                              },
                              onLongPress: () async {
                                var map={
                                  'id':controller.arrStudent[index].id
                                };
                               var value=await Get.toNamed(Routes.EDIT_CHILD,arguments: map);
                                if(value!=null){
                                  controller.getChildList();
                                }
                              },
                              child:ChildView(controller.arrStudent[index],
                               isSelected:controller.index.value == index
                              )
                            );

                        }),
                      ),

                      Row(
                        children: [






                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SelectionDropdown(
                        hint: 'subject'.tr,
                        levelValue: course==null?null:course.subject.name,
                        subLevelValue: 'material'.tr,
                        onTap: () async {
                          if(controller.arrCourseList.value.isNotEmpty){
                          var value = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                               backgroundColor: Colors.transparent,
                              builder: (context)=>
                                  CourseSelection(controller.arrCourseList.value)
                          );
                          if(value!=null){
                            setState(() {
                              course=value;
                            });
                          }

                        }}
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SelectionDropdown(
                        hint: 'date_time'.tr,
                        levelValue: scheduleModel==null?null:Utils.convertBookingTime(scheduleModel.startDate),
                        onTap: () async {
                          if(course==null){
                            Utils.errorToast('select_reservation_course');
                          }else{
                            var map={
                              'id':'8a0080547b1c0554017b1c10839d0002'
                              // 'id':course.id
                            };
                           var value=await Get.offNamedUntil(Routes.RESERVATION_DATETIME, (route) => true,arguments: map);
                           if(value!=null){
                              setState(() {
                                scheduleModel=value;
                              });
                           }

                          }

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
                            description=v;
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
                        child: controller.isBack.value?Center(
                          child: CircularProgressIndicator(),
                        ):RaisedGradientButtonGreen(
                          margin: const EdgeInsets.all(0),
                          onPressed: (){
                            controller.addReservation(
                              controller.arrStudent[controller.index.value],
                              course,
                              scheduleModel,
                              description
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
                      )


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}