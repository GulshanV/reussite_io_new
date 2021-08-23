import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/tools.dart';

import '../../utils.dart';
import 'bookdate_controller.dart';

class ReservationDatePicker extends StatefulWidget {
  @override
  _ReservationDatePicker createState() => _ReservationDatePicker();
}

class _ReservationDatePicker extends State<ReservationDatePicker> {
  final controller = Get.put(BookDateController());

  @override
  void initState() {
    super.initState();
    controller.getSlot();
  }

  int slotIndex = -1;
  var currentMonth = DateTime.now();
  var currentDate = DateTime.now();

  EventList<Event> getEvent() {
    var map = Map<DateTime, List<Event>>();
    for (int i = 0; i < controller.arrSchedule.length; i++) {
      var d = controller.arrSchedule[i].startDate.toString().split(' ')[0];
      var format = DateFormat('MM/dd/yyyy').parse(d);
      List<Event> list = [];
      list.add(Event(
        date: format,
        title: '$i',
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          height: 5.0,
          width: 5.0,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(2.5)),
        ),
      ));
      map[format] = list;
    }
    EventList<Event> event = EventList<Event>(events: map);

    return event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ToolsBar(
            title: 'select_day'.tr,
          ),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*     Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: const SizedBox(),
                            ),
                            Text(
                              DateFormat.LLLL().format(currentMonth),
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w500,
                                  color: PsColors.mainColor,
                                  fontSize: 20
                              ),
                            ),
                            const SizedBox(width: 10,),
                            InkWell(
                              onTap: (){

                                if(currentPage>0){
                                  pageController.jumpToPage(currentPage+1);
                                }

                              },
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                size: 30,
                                color: PsColors.mainColor,
                              ),
                            )
                          ],
                        ),
                      ),*/
                        CalendarCarousel<Event>(
                          onDayPressed: (date, events) {
                            this.setState(() => currentDate = date);
                            controller.clearSlot();
                            events.forEach((event) {
                              controller.selectEvent(event.title);
                            });
                          },
                          onCalendarChanged: (d) {
                            setState(() {
                              currentMonth = d;
                            });
                          },
                          weekdayTextStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: PsColors.weekendColor),
                          weekendTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: PsColors.dark_textcolor),
                          daysTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: PsColors.black),
                          headerTextStyle: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: PsColors.mainColor),
                          iconColor: Color(0xffABE237),
                          leftButtonIcon: Icon(
                            Icons.keyboard_arrow_left,
                            size: 25,
                            color: Color(0xff86C502),
                          ),
                          thisMonthDayBorderColor: Colors.grey,
                          weekDayFormat: WeekdayFormat.narrow,
                          markedDatesMap: getEvent(),
                          height: 320.0,
                          selectedDateTime: currentDate,
                          showIconBehindDayText: true,
                          customGridViewPhysics: NeverScrollableScrollPhysics(),
                          markedDateShowIcon: false,
                          markedDateIconMaxShown: 2,
                          showHeader: true,
                          selectedDayTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          selectedDayButtonColor: Color(0xffABE237),
                          todayTextStyle: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          minSelectedDate:
                              DateTime.now().add(Duration(days: -1)),
                          maxSelectedDate:
                              DateTime.now().add(Duration(days: 360)),
                          todayButtonColor: Colors.transparent,
                          todayBorderColor: Color(0xffABE237),
                          childAspectRatio: 1.2,
                          markedDateMoreShowTotal: true,
                          markedDateCustomShapeBorder:
                          ContinuousRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(40)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: controller.arrSlot.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 4.5),
                            ),
                            padding: EdgeInsets.all(8),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    slotIndex = index;
                                  });
                                },
                                child: new Container(
                                  decoration: BoxDecoration(
                                      color: slotIndex == index
                                          ? Color(0xffABE237)
                                          : Color(0xffE4EFEC),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.all(5),
                                  child: Center(
                                    child: Text(
                                      Utils.convertTime(
                                          controller.arrSlot[index].startDate),
                                      style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: slotIndex == index
                                              ? PsColors.white
                                              : PsColors.black),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RaisedGradientButtonGreen(
                            margin: const EdgeInsets.all(0),
                            onPressed: () {
                              if (slotIndex >= 0) {
                                Get.back(result: controller.arrSlot[slotIndex]);
                              }
                              // Get.offNamedUntil(Routes.HOME, (route) => true);
                            },
                            width: 200,
                            child: Text(
                              'next'.tr.toUpperCase(),
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
                        )
                      ],
                    ),
                  )),
          )
        ],
      ),
    );
  }
}
