import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/ui/add_child/home_controller.dart';
import 'package:reussite_io_new/widget/child_view.dart';
import 'package:reussite_io_new/widget/tools.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
class BookListWithCalender extends StatefulWidget{
final HomeController controller;
BookListWithCalender(this.controller);

  @override
  _BookListWithCalender createState()=>_BookListWithCalender();
}
class _BookListWithCalender extends State<BookListWithCalender>{


  int slotIndex=-1;
  var currentMonth = DateTime.now();
  var currentDate = DateTime.now();

  EventList<Event> getEvent(){
    var map=Map<DateTime,List<Event>>();
    // for(int i=0;i<controller.arrSchedule.length;i++){
    //   var d= controller.arrSchedule[i].startDate.toString().split(' ')[0];
    //   var format = DateFormat('MM/dd/yyyy').parse(d);
    //   List<Event> list =[];
    //   list.add(Event(
    //     date: format,
    //     title: '$i',
    //     dot: Container(
    //       margin: EdgeInsets.symmetric(horizontal: 1.0),
    //       height: 5.0,
    //       width: 5.0,
    //       decoration: BoxDecoration(
    //           color: Colors.green,
    //           borderRadius: BorderRadius.circular(2.5)
    //       ),
    //     ),
    //   ));
    //   map[format]=list;
    // }
    EventList<Event> event=EventList<Event>(
        events:map
    );

    return event;

  }





  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
        backgroundColor: PsColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [



            Expanded(
              child:Padding(
                padding: const EdgeInsets.only(
                    left: 10,
                    right: 10
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      CalendarCarousel<Event>(
                        onDayPressed: (date, events) {
                          this.setState(() => currentDate = date);
                          // controller.clearSlot();
                          // events.forEach((event){
                          //   controller.selectEvent(event.title);
                          // });
                        },
                        weekdayTextStyle:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: PsColors.weekendColor
                        ),
                        weekendTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: PsColors.dark_textcolor
                        ),
                        daysTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: PsColors.black
                        ),
                        thisMonthDayBorderColor: Colors.grey,
                        weekDayFormat: WeekdayFormat.narrow,
                        markedDatesMap: getEvent(),
                        height: 280.0,
                        selectedDateTime: currentDate,
                        showIconBehindDayText: true,
                        customGridViewPhysics: NeverScrollableScrollPhysics(),
                        markedDateShowIcon: false,
                        markedDateIconMaxShown: 2,
                        showHeader: false,
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

                        minSelectedDate:DateTime.now().add(Duration(days: -1)),
                        maxSelectedDate: DateTime.now().add(Duration(days: 360)),
                        todayButtonColor: Colors.transparent,
                        todayBorderColor: Color(0xffABE237),
                        childAspectRatio: 1.2,

                        markedDateMoreShowTotal: true,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left:10.0,right:10),
                        child: Wrap(
                          children:  List.generate(7, (index) => Row(
                            children: [
                              Text.rich(
                                  TextSpan(
                                  text: '$index',
                                  style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w300,
                                      color: PsColors.meetLinkColor,
                                      fontSize: 22
                                  ),
                                  children: [
                                    TextSpan(
                                        text: 'AM',
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w500,
                                            color: PsColors.meetLinkColor,
                                            fontSize: 11
                                        )
                                    )
                                  ]
                              ),
                                // textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: index%2==0?null:PsColors.mainColor,
                                  border: Border.all(
                                    color: PsColors.hintColor.withOpacity(0.5),
                                    width: 0.5
                                  )
                                ),
                              ))
                            ],
                          )),
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
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text(
                'Select a child to see his reservations',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: PsColors.black
                ),
              ),
              const SizedBox(height: 20,),
              Wrap(
                children: List.generate(widget.controller.arrStudent.length, (index){

                  return  InkWell(
                      onTap: (){
                        widget.controller.changeIndex(index);
                      },
                      onLongPress: () async {
                        var map={
                          'id':widget.controller.arrStudent[index].id
                        };
                        var value=await Get.toNamed(Routes.EDIT_CHILD,arguments: map);
                        if(value!=null){
                          print('Delete: $value');
                        }
                      },
                      child:ChildView(widget.controller.arrStudent[index],
                          isSelected:widget.controller.index.value == index
                      )
                  );

                }),
              )
            ],
          ),
        )

    ));
  }
}