import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/model/comment_model.dart';

import '../../utils.dart';

class NotificationView extends StatelessWidget{
  final CommentModel model;
  final String subject;
  NotificationView(this.model,this.subject);

   @override
  Widget build(BuildContext context) {

     return Padding(
       padding: const EdgeInsets.only(left: 20.0,right: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             children: [
               Expanded(
                 child: Text(
                   '${model.commentur.firstName??''} ${model.commentur.lastName??''}',
                   style: GoogleFonts.notoSans(
                     fontWeight: FontWeight.w500,
                     color: PsColors.black,
                     fontSize: 16
                   ),
                 ),
               ),
               Text(
                 Utils.convertChatTime(model.createDate),
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
             model.content??'',
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
                 'For ${'${model.studentProfile.firstName??''} ${model.studentProfile.lastName??''}'} ${subject??''} ',
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
       ),
     );

  }
}