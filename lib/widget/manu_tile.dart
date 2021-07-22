import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';

class MenuLevel extends StatelessWidget{
  final String hint;
  final String levelValue;
  final Function onTap;
  MenuLevel({this.hint,this.onTap,this.levelValue});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        const SizedBox(height: 15,),
        InkWell(
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
                  fontWeight: FontWeight.w500,
                  color: levelValue==null?PsColors.hintColor:PsColors.black,
                  fontSize: 18
                ),
              ),
              Expanded(child: const SizedBox()),

              Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: PsColors.mainColor,
              )
            ],
          ),
        ),
        const SizedBox(height: 7,),
        Divider(
          color: PsColors.borderlineColor,
        ),
        const SizedBox(height: 7,),
      ],
    );
  }
}