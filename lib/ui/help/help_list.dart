import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';

class HelpListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsColors.white,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 45, left: 15, right: 15, bottom: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 13.29,
                    width: 16.75,
                    child: Icon(
                      Icons.arrow_back,
                      color: PsColors.mainColor,
                    ),
                  ),
                ),
                Expanded(child: const SizedBox()),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'help'.tr,
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: PsColors.mainColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  getView(
                      'assets/images/help_girl.png', 'create_child_profile'.tr),
                  getView('assets/images/help_calendar.png',
                      'create_child_sreserve'.tr),
                  getView('assets/images/help_link.png',
                      'click_hyperlink_profile'.tr),
                  getView('assets/images/help_book.png',
                      'click_parenting_guide'.tr),
                ],
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget getView(String image, String title) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 80,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500,
                  color: PsColors.dark_textcolor,
                  fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right_sharp,
            size: 20,
            color: PsColors.mainColor,
          )
        ],
      ),
    );
  }
}
