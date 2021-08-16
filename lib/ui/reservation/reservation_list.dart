import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/ui/add_child/home_controller.dart';
import 'package:reussite_io_new/widget/button_green.dart';

import '../../utils.dart';



class ReservationList extends StatelessWidget{
  final HomeController controller;
  ReservationList(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Image.asset(
          'assets/icons/no_reservation_found.png',
          height: 150,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'there_is_no_reservations'.tr,
           style: GoogleFonts.notoSans(
             fontWeight: FontWeight.w400,
             color: PsColors.dark_textcolor,
             fontSize: 16
           ),
        ),
        const SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.center,
          child: RaisedGradientButtonGreen(
            margin: const EdgeInsets.all(0),
            onPressed: () async {
               var value = await Get.offNamedUntil(Routes.ADD_RESERVATION, (route) => true);
               if(value!=null){
                 Utils.successToast('booking_create_successfully');
               }
               controller.getChildList();
            },
            width: 130,
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'add'.tr.toUpperCase(),
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: PsColors.white
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: (){
              controller.getChildList();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.refresh,
                  size: 30,
                ),
                Text(
                  'Retry',
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w400,
                      color: PsColors.dark_textcolor,
                      fontSize: 16
                  ),
                )
              ],
            ),
          ),
        )


      ],
    );
  }
}