import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';

class SelectionDropdown extends StatelessWidget{
  final String hint;
  final String levelValue;
  final String subLevelValue;
  final Function onTap;
  final bool hideArrow;
  SelectionDropdown({this.hint,this.onTap,this.hideArrow=false,this.levelValue,this.subLevelValue});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: PsColors.borderlineColor,
          width: 1
        )
      ),
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: (){
          if(onTap!=null){
            onTap();
          }
        },
        child: Row(
          children: [
            Text(
              levelValue??hint??'',
              style: GoogleFonts.notoSans(
                fontWeight: levelValue==null?FontWeight.w500:FontWeight.w600,
                color: levelValue==null?PsColors.hintColor:PsColors.black,
                fontSize: 14
              ),
            ),
            Expanded(child: const SizedBox()),
            Text(
              subLevelValue??'',
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500,
                  color: PsColors.hintColor,
                  fontSize: 10
              ),
            ),
            hideArrow?const SizedBox():Icon(
              Icons.keyboard_arrow_right,
              size: 20,
              color: PsColors.mainColor,
            )
          ],
        ),
      ),
    );
  }
}