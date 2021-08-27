import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/model/student.dart';
class ChildView extends StatelessWidget{
  final Student model;
  final bool isSelected;
  ChildView(this.model,{this.isSelected=false});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: isSelected?80:60,
          width:  isSelected?80:60,
          margin: const EdgeInsets.only(
              right: 10
          ),
          decoration: BoxDecoration(
              color: PsColors.light_grey,
              borderRadius: BorderRadius.circular(15),
            border: isSelected?Border.all(
              color: PsColors.mainColor,
              width: 3
            ):null
          ),
          padding: const EdgeInsets.all(5),
          child: Image.asset(
              'assets/images/placeholder_girl.png'
          ),
        ),
        Text(
          model.firstName??'',
          style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w400,
              color: PsColors.black,
              fontSize: 12
          ),
        )
      ],
    );
  }
}