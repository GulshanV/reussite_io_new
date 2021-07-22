import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/widget/tools.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

class ReservationDatePicker extends StatefulWidget{

  @override
  _ReservationDatePicker createState()=>_ReservationDatePicker();
}
class _ReservationDatePicker extends State<ReservationDatePicker>{
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  final ValueNotifier<List<String>> _selectedEvents = ValueNotifier([]);
  List<String> _getEventsForDay(DateTime day) {
    // Implementation example
    return ['',''];
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
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: const SizedBox(),
                          ),
                          Text(
                            'July',
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w500,
                                color: PsColors.mainColor,
                                fontSize: 20
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                            color: PsColors.mainColor,
                          )
                        ],
                      ),
                    ),
                    TableCalendar<String>(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now(),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      headerVisible: false,
                      eventLoader: _getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      selectedDayPredicate: (day) {
                        // Use values from Set to mark multiple days as selected
                        return true;//_selectedDays.contains(day);
                      },
                      onDaySelected:null,
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      // onPageChanged: (focusedDay) {
                      //   _focusedDay = focusedDay;
                      // },
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ValueListenableBuilder<List<String>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return GridView.builder(
                            itemCount: 12,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:  3,
                              childAspectRatio: MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 4),
                            ),
                            padding: EdgeInsets.all(8),
                            itemBuilder: (BuildContext context, int index) {
                              return new Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffE4EFEC),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                margin: const EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    '09:30 am',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: PsColors.black
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
            )


          ],
        ),

        bottomNavigationBar: Container(
          height: 150,
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


                ],
              ),
            ],
          ),
        ),
      );
  }
}