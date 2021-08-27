import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/widget/button_green.dart';
import 'package:reussite_io_new/widget/hide_button.dart';

class DescriptionPopup extends StatefulWidget{

  @override
  _DescriptionPopup createState()=>_DescriptionPopup();

}

class _DescriptionPopup extends State<DescriptionPopup>{

    String description;

    @override
  Widget build(BuildContext context) {

      return Container(
        height: 300,
        color: PsColors.white,
        child:  Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: PsColors.borderlineColor,
                      width: 0.5)),
              child: TextField(
                onChanged: (v) {
                  setState(() {
                    description = v;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 20, right: 0, top: 15, bottom: 15),
                    hintText: 'assistance_description'.tr,
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: PsColors.hintColor,
                        fontStyle: FontStyle.normal,
                        fontSize: 15),
                    counterText: ""),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: PsColors.black,
                    fontSize: 16),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                maxLines: 5,
                minLines: 5,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child:description == null || description == ''
                  ? RaisedGradientHideButton(
                color: PsColors.disableColor,
                margin: const EdgeInsets.all(0),
                onPressed: () {},
                width: 200,
                child: Text(
                  'create'.tr.toUpperCase(),
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: PsColors.white),
                  textAlign: TextAlign.center,
                ),
              )
                  : RaisedGradientButtonGreen(
                margin: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context,description);
                },
                width: 200,
                child: Text(
                  'book_now'.tr.toUpperCase(),
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: PsColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
  }
}