import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';

class NotificationView extends StatelessWidget{

   @override
  Widget build(BuildContext context) {

     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           children: [
             Expanded(
               child: Text(
                 'Cristofer Mango',
                 style: GoogleFonts.notoSans(
                   fontWeight: FontWeight.w500,
                   color: PsColors.black,
                   fontSize: 16
                 ),
               ),
             ),
             Text(
               '21.05.18',
               style: GoogleFonts.notoSans(
                   fontWeight: FontWeight.w500,
                   color: PsColors.hintColor,
                   fontSize: 12
               ),
             ),
           ],
         ),
         const SizedBox(
           height: 10,
         ),
         Text(
           'Sometime the tutor sends comments to the parent via the app. It would be great for parent to see those comments. ',
           style: GoogleFonts.notoSans(
               fontWeight: FontWeight.w400,
               color: PsColors.dark_textcolor,
               fontSize: 14
           ),
           textAlign: TextAlign.start,
         ),

         const SizedBox(
           height: 20,
         ),

         Row(
           children: [
             Container(
               height: 20,
               width: 20,
               margin: const EdgeInsets.only(
                   right: 10
               ),
               decoration: BoxDecoration(
                   color: PsColors.light_grey,
                   borderRadius: BorderRadius.circular(5)
               ),
               child: Image.asset(
                   'assets/dummy/squircle.png'
               ),
             ),
             Text(
               'For Rayna Stanton. Mathematics ',
               style: GoogleFonts.notoSans(
                   fontWeight: FontWeight.w400,
                   color: PsColors.hintColor,
                   fontSize: 12
               ),
               textAlign: TextAlign.start,
             ),
           ],
         ),
         const SizedBox(
           height: 20,
         ),
         Divider(
           color: PsColors.borderlineColor,
         ),
         const SizedBox(
           height: 20,
         ),
       ],
     );

  }
}