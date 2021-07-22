import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';

class ToolsBar extends StatelessWidget{
  final String title;
  ToolsBar({this.title});

    @override
  Widget build(BuildContext context) {
      return Padding(
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
            Expanded(child: Text(
                title??'',
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
      );
  }
}