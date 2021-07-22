import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:get/get.dart';

import 'input.dart';

class MobileWidget extends StatelessWidget{

    @override
  Widget build(BuildContext context) {

      return Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
              color: PsColors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 12,
              right: 7,
              left: 7
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '+123',
                     style: GoogleFonts.notoSans(
                       fontSize: 16,
                       color: PsColors.black,
                       fontWeight: FontWeight.w600
                     ),
                    maxLines: 1,
                  ),
                ),

                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                )

              ],
            ),
          ),

          Expanded(child:InputWidget(
            hint: 'mobile_number'.tr,
            margin: const EdgeInsets.all(0),
            onChange:(v){},
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ))
        ],
      );
  }
}