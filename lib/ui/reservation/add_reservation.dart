import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/controller/add_reservation_controller.dart';
import 'package:reussite_io_new/model/course_model.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/ui/selection/course_selection.dart';
import 'package:reussite_io_new/utils.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/child_view.dart';
import 'package:reussite_io_new/widget/hide_button.dart';
import 'package:reussite_io_new/widget/selection_dropdown.dart';

class AddNewReservation extends StatefulWidget {
  final  Course course;
  final ScheduleModel scheduleModel;
  final Student student;
  AddNewReservation({this.course,this.scheduleModel,this.student});

  @override
  _AddNewReservation createState() => _AddNewReservation();
}

class _AddNewReservation extends State<AddNewReservation> {
  final AddReservationController controller =
      Get.put(AddReservationController());


  String description;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: PsColors.white,
          body: WillPopScope(
            onWillPop: () async {
              if (!controller.isBack.value) {
                return true;
              } else {
                return false;
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 45, left: 15, right: 15, bottom: 10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {

                            if (!controller.isBack.value) {
                              Navigator.pop(context);
                            }
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: PsColors.mainColor,
                          )
                      ),
                      Expanded(
                          child: Text(
                        '',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w400,
                            color: PsColors.toolTitleColor,
                            fontSize: 20),
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
                      padding:
                          const EdgeInsets.only(top: 0, left: 25, right: 25),
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
                                color: PsColors.mainColor),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          ChildView(
                              widget.student,
                              isSelected:false
                            ),


                          const SizedBox(
                            height: 20,
                          ),
                          SelectionDropdown(
                              hint: 'subject'.tr,
                              levelValue:widget.course.name,
                              hideArrow:true,
                              subLevelValue: widget.course == null ? null : 'subject'.tr,
                              onTap: () async {

                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          SelectionDropdown(
                            hint: 'date_time'.tr,
                            hideArrow:true,
                            levelValue: Utils.convertBookingTime(widget.scheduleModel.startDate),
                            onTap: () async {
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
                                    width: 0.5)),
                            child: TextField(
                              onChanged: (v) {
                                setState(() {
                                  description = v;
                                });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                      left: 20, right: 0, top: 15, bottom: 15),
                                  hintText: 'assistance_description'.tr,
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: PsColors.hintColor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15),
                                  counterText: ""),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: PsColors.black,
                                  fontSize: 16),
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
                            child: controller.isBack.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : description == null || description == ''
                                    ? RaisedGradientHideButton(
                                        color: PsColors.disableColor,
                                        margin: const EdgeInsets.all(0),
                                        onPressed: () {},
                                        width: 200,
                                        child: Text(
                                          'create'.tr.toUpperCase(),
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                              color: PsColors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : RaisedGradientButtonGreen(
                                        margin: const EdgeInsets.all(0),
                                        onPressed: () {
                                          controller.addReservation(
                                              widget.student,
                                              widget.course,
                                              widget.scheduleModel,
                                              description);
                                        },
                                        width: 200,
                                        child: Text(
                                          'create'.tr.toUpperCase(),
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                              color: PsColors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
