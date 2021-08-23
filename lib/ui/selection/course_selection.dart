import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/model/course_model.dart';
import 'package:reussite_io_new/model/course_selection_model.dart';

class CourseSelection extends StatefulWidget{
  final List<CourseSelectionModel> arrCourse;
  CourseSelection(this.arrCourse);

  @override
  _CourseSelection createState()=>_CourseSelection();
}

class _CourseSelection extends State<CourseSelection>{

    @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: PsColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )
          ),
          margin: const EdgeInsets.only(top:100),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: PsColors.mainColor,
                      size: 25,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'material'.tr,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        color: PsColors.dark_textcolor,
                        fontSize: 19
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  )

                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.arrCourse.length,
                  itemBuilder: (context,index){
                    var m = widget.arrCourse[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:20),
                          child: Text(
                            m.courseName??'',
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w500,
                                color: PsColors.mainColor,
                                fontSize: 15
                            ),
                          ),
                        ),
                        Wrap(
                          children: m.arrCourse.map((e) => InkWell(
                            onTap:(){
                              Navigator.pop(context,e);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: PsColors.hintColor,
                                            width: 1
                                        )
                                    )
                                ),
                                padding: const EdgeInsets.only(
                                  top: 15,bottom: 5
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Grade (${e.arrGrades.join(',')}) ',
                                      style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.w600,
                                          color: PsColors.textColor,
                                          fontSize: 15
                                      ),
                                    ),
                                    Text(
                                      e.language,
                                      style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.w600,
                                          color: PsColors.mainColor,
                                          fontSize: 15
                                      ),
                                    ),
                                    Expanded(
                                      child: const SizedBox(),
                                    ),
                                    Text(
                                      e.prices.length==0?'':'${e.prices[0].currencyCode} ',
                                      style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.w600,
                                          color: PsColors.mainColor,
                                          fontSize: 15
                                      ),
                                    ),
                                    Text(
                                      e.prices.length==0?'':'${e.prices[0].amount}',
                                      style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.w600,
                                          color: PsColors.btnColor,
                                          fontSize: 15
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          )).toList(),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),

      );
  }
}