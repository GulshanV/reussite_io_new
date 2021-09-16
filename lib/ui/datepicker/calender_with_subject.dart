import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/ui/add_child/home_controller.dart';
import 'package:reussite_io_new/ui/reservation/add_reservation.dart';
import 'package:reussite_io_new/ui/reservation/description_popu.dart';
import 'package:reussite_io_new/utils.dart';
import 'package:reussite_io_new/widget/child_view.dart';

class BookListWithCalender extends StatefulWidget {
  final HomeController controller;

  BookListWithCalender(this.controller);

  @override
  _BookListWithCalender createState() => _BookListWithCalender();
}

class _BookListWithCalender extends State<BookListWithCalender> {
  int slotIndex = -1;
  var currentMonth = DateTime.now();
  var currentDate=null; //= DateTime.now();

  // int diffInDays (DateTime date2) {
  //   DateTime date1 = DateTime.now().add(Duration(days: -1));
  //   return ((date1.difference(date2) - Duration(hours: date1.hour) + Duration(hours: date2.hour)).inHours / 24).round();
  // }

  EventList<Event> getEvent() {
    var map = Map<DateTime, List<Event>>();

    for (int i = 0; i < widget.controller.arrBooking.length; i++) {
      var d = widget.controller.arrBooking[i].startDate.toString().split(' ')[0];
      bool isBooking = widget.controller.arrBooking[i].isBooking;
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
              color: isBooking ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(2.5)),
        ),
      ));

      map[format] = list;
    }

    EventList<Event> event = EventList<Event>(events: map);
    widget.controller.clearSubject();
    event.getEvents(currentDate).forEach((event) {widget.controller.selectEvent(event.title);});


    return event;
  }

  EventList<Event> getAvailable() {
    var map = Map<DateTime, List<Event>>();
    for (int i = 0; i < widget.controller.arrAllSchedule.length; i++) {
      var d = widget.controller.arrAllSchedule[i].startDate.toString().split(' ')[0];
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
              color: Colors.grey, borderRadius: BorderRadius.circular(2.5)),
        ),
      ));
      map[format] = list;
    }
    EventList<Event> event = EventList<Event>(events: map);

     widget.controller.clearSlot();
     event.getEvents(currentDate).forEach((event) {widget.controller.selectAvalibleSlot(event.title);});

    return event;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: PsColors.white,
        body: widget.controller.isLoadingSlot.value
            ? Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.controller.index.value == 10001
                                ? CalendarCarousel<Event>(
                                    onDayPressed: (date, events) {
                                      this.setState(() => currentDate = date);
                                      widget.controller.clearSlot();
                                      events.forEach((event) {
                                        widget.controller.selectAvalibleSlot(event.title);
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
                                    thisMonthDayBorderColor: Colors.grey,
                                    weekDayFormat: WeekdayFormat.narrow,
                                    markedDatesMap: getAvailable(),
                                    height: 350.0,
                                    selectedDateTime: currentDate,
                                    showIconBehindDayText: true,
                                    customGridViewPhysics:
                                        NeverScrollableScrollPhysics(),
                                    markedDateShowIcon: false,
                                    markedDateIconMaxShown: 2,
                                    pageSnapping: true,
                                    showHeader: true,
                                    selectedDayTextStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    headerTextStyle: GoogleFonts.notoSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: PsColors.mainColor),
                                    iconColor: Colors.grey,
                                    leftButtonIcon: Icon(
                                      Icons.keyboard_arrow_left,
                                      size: 25,
                                      color: Color(0xff86C502),
                                    ),
                              rightButtonIcon: Icon(
                                Icons.keyboard_arrow_right,
                                size: 25,
                                color: Color(0xff86C502),
                              ),
                                    selectedDayButtonColor: Color(0xffABE237),
                                    todayTextStyle: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    minSelectedDate:
                                        DateTime.now().add(Duration(days: -90)),
                                    maxSelectedDate:
                                        DateTime.now().add(Duration(days: 360)),
                                    todayButtonColor: Colors.transparent,
                                    todayBorderColor: Color(0xffABE237),
                                    childAspectRatio: 1.2,
                                    markedDateMoreShowTotal: true,
                                    // markedDateIconMargin:10,
                                    markedDateCustomShapeBorder:
                                        ContinuousRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                  )
                                : CalendarCarousel<Event>(
                                    onDayPressed: (date, events) {
                                      this.setState(() => currentDate = date);
                                      widget.controller.clearSubject();
                                      events.forEach((event) {widget.controller.selectEvent(event.title);});
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
                                    thisMonthDayBorderColor: Colors.grey,
                                    weekDayFormat: WeekdayFormat.narrow,
                                    markedDatesMap: getEvent(),
                                    height: 350.0,
                                    selectedDateTime: currentDate,
                                    showIconBehindDayText: true,
                                    customGridViewPhysics:
                                        NeverScrollableScrollPhysics(),
                                    markedDateShowIcon: false,
                                    markedDateIconMaxShown: 2,
                                    pageSnapping: true,
                                    showHeader: true,
                                    selectedDayTextStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
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
                              rightButtonIcon: Icon(
                                Icons.keyboard_arrow_right,
                                size: 25,
                                color: Color(0xff86C502),
                              ),
                                    selectedDayButtonColor: Color(0xffABE237),
                                    todayTextStyle: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    minSelectedDate:
                                        DateTime.now().add(Duration(days: -90)),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, top: 15),
                              child: widget.controller.index.value == 10001
                                  ? Wrap(
                                      children: List.generate(
                                          widget.controller.arrAvailableSlot
                                              .length, (index) {
                                        var time = Utils.convertTime(widget
                                                .controller
                                                .arrAvailableSlot[index]
                                                .startDate)
                                            .split(' ');
                                        return Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text:
                                                    '${time[0].replaceAll(new RegExp(r'^0+(?=.)'), '')}',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w300,
                                                  color: PsColors.meetLinkColor,
                                                  fontSize: 15,
                                                ),
                                                children: [
                                                  WidgetSpan(
                                                    child: Transform.translate(
                                                      offset: const Offset(
                                                          0.0, -7.0),
                                                      child: Text(
                                                        time.length > 1
                                                            ? time[1]
                                                            : '',
                                                        style: GoogleFonts
                                                            .notoSans(
                                                          fontWeight: FontWeight.w500,
                                                          color: PsColors.meetLinkColor,
                                                          fontSize: 08,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                                child: InkWell(
                                                  onTap:(){
                                                    Utils.successToast('Please select a child to make a reservation');
                                                  },
                                                  child: Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                              /*  color: (index > 0 &&
                                                          widget.controller.arrAvailableSlot[index - 1].course.name == widget.controller.arrAvailableSlot[index].course.name)
                                                      ? null
                                                      : PsColors.mainColor,*/
                                                  border: Border.all(
                                                    color: PsColors.hintColor
                                                        .withOpacity(0.5),
                                                    width: 0.3,
                                                  ),
                                              ),
                                              child: (index > 0 &&
                                                        widget.controller.arrAvailableSlot[index - 1].course.name == widget.controller.arrAvailableSlot[index].course.name)
                                                    ? null
                                                    : Center(
                                                        child: Text(
                                                          widget.controller.arrAvailableSlot[index].course.name ?? '',
                                                          style: GoogleFonts
                                                              .notoSans(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 13,
                                                                  color:Colors.black54),
                                                        ),
                                                      ),
                                            ),
                                                ))
                                          ],
                                        );
                                      }),
                                    )
                                  : Wrap(
                                      children: List.generate(
                                          widget.controller.arrSubjectList.length, (index) {
                                        var time = Utils.convertTime(widget.controller.arrSubjectList[index].schedule.startDate).split(' ');
                                        var isbooking=widget.controller.arrSubjectList[index].isBooking;
                                        return Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text:
                                                    '${time[0].replaceAll(new RegExp(r'^0+(?=.)'), '')}',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w300,
                                                  color: PsColors.meetLinkColor,
                                                  fontSize: 15,
                                                ),
                                                children: [
                                                  WidgetSpan(
                                                    child: Transform.translate(
                                                      offset: const Offset(
                                                          0.0, -7.0),
                                                      child: Text(
                                                        time.length > 1
                                                            ? time[1]
                                                            : '',
                                                        style: GoogleFonts
                                                            .notoSans(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: PsColors
                                                              .meetLinkColor,
                                                          fontSize: 08,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                                child: InkWell(
                                              onTap: () async {
                                                if(widget.controller.arrSubjectList[index].isBooking){
                                                  var map = {
                                                    'id': widget.controller.arrSubjectList[index].id,
                                                    'subject': widget.controller.arrSubjectList[index].schedule.course.name,
                                                    'stdId': widget.controller.arrStudent[widget.controller.index.value].id,
                                                    'stdFirstName': widget.controller.arrStudent[widget.controller.index.value].firstName,
                                                    'stdLastName': widget.controller.arrStudent[widget.controller.index.value].lastName,
                                                  };
                                                  var value = await Get.toNamed(Routes.COMMENT, arguments: map);
                                                }else{
                                                 var sch = widget.controller.arrSubjectList[index].schedule;

                                                 var value = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewReservation(
                                                   course:  sch.course,
                                                   scheduleModel: sch,
                                                   student: widget.controller.arrStudent[widget.controller.index.value],
                                                 )));

                                                  if (value != null) {
                                                    Utils.successToast('booking_created_successfully'.tr);
                                                    currentDate=null;
                                                    widget.controller.getBookingListChildId(isCallBooking: true
                                                    );
                                                  }

                                              }},
                                              child: Container(
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: (index > 0 &&
                                                            widget.controller.arrSubjectList[index - 1].schedule.course.name == widget.controller.arrSubjectList[index].schedule.course.name)
                                                        ? null
                                                        : isbooking?PsColors.mainColor:null,
                                                    border: Border.all(
                                                        color: PsColors.hintColor.withOpacity(0.5),
                                                        width: 0.5)),
                                                child: (index > 0 &&
                                                        widget.controller.arrSubjectList[index - 1].schedule.course.name == widget.controller.arrSubjectList[index].schedule.course.name)
                                                    ? null
                                                    : Center(
                                                        child: Text(
                                                          widget.controller.arrSubjectList[index].schedule.course.name ?? '',
                                                          style: GoogleFonts.notoSans(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 13,
                                                                  color: isbooking?PsColors.white:Colors.black54),
                                                        ),
                                                      ),
                                              ),
                                            ))
                                          ],
                                        );
                                      }),
                                    ),
                            ),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
        bottomNavigationBar: Container(
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
            color: PsColors.btnColor,
          ),
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: widget.controller.index.value == 10001
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'select_child_to_see_booking'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: PsColors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...List.generate(
                              widget.controller.arrStudent.length, (index) {
                            return InkWell(
                                onTap: () {
                                  currentDate=null;
                                  widget.controller.changeIndex(index);
                                },
                                onLongPress: () async {
                                  var map = {
                                    'id': widget.controller.arrStudent[index].id
                                  };
                                  var value = await Get.toNamed(Routes.EDIT_CHILD,
                                      arguments: map);
                                  // if(value!=null){
                                  widget.controller.getChildList();
                                  // }
                                },
                                child: ChildView(
                                    widget.controller.arrStudent[index],
                                    isSelected:
                                    widget.controller.index.value == index
                                )
                            );
                          }),

                          InkWell(
                            onTap: () async {
                              var value = await Get.offNamedUntil(Routes.ADD_NEW_CHILD, (route) => true);

                              if(value!=null)
                                 widget.controller.getChildList();
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: const EdgeInsets.only(
                                      right: 10
                                  ),
                                  decoration: BoxDecoration(
                                      color: PsColors.mainColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: PsColors.mainColor,
                                          width: 3
                                      )
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child:Icon(
                                    Icons.add,
                                    size: 40,
                                    color:Colors.white
                                  )
                                ),
                                Text(
                                  'add_child_a'.tr,
                                  style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w400,
                                      color: PsColors.black,
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: PsColors.mainColor,
                              borderRadius: BorderRadius.circular(15)),
                          child:widget.controller.arrStudent[widget.controller.index.value].imagePath!=null?ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                                File(widget.controller.arrStudent[widget.controller.index.value].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ): Image.asset(
                              'assets/images/placeholder_girl.png'
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.controller.arrStudent[widget.controller.index.value].conferenceUrl ?? ''}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: PsColors.black),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            currentDate=null;
                            widget.controller.changeIndex(10001);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: PsColors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(Icons.close),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap:() async {
                            var map = {
                              'id': widget.controller.arrStudent[widget.controller.index.value].id
                            };
                            var value = await Get.toNamed(Routes.EDIT_CHILD,
                                arguments: map);
                            if(value!=null){
                              widget.controller.getChildList();
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: PsColors.light_grey,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: PsColors.mainColor, width: 3)),
                            padding: const EdgeInsets.all(5),
                            child:widget.controller.arrStudent[widget.controller.index.value].imagePath!=null?ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(widget.controller.arrStudent[widget.controller.index.value].imagePath),
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                            ): Image.asset('assets/images/placeholder_girl.png'),
                          ),
                        ),
                        Text(
                          '${widget.controller.arrStudent[widget.controller.index.value].firstName ?? ''} ${widget.controller.arrStudent[widget.controller.index.value].lastName ?? ''}',
                          style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w600,
                              color: PsColors.black,
                              fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
        )));
  }
}
