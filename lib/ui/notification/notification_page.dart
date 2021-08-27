import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/model/comment_model.dart';
import 'package:reussite_io_new/services/cqapi.dart';
import 'package:reussite_io_new/services/request_api.dart';
import 'notification_view.dart';

class NotificationPage extends StatefulWidget{

  @override
  _NotificationPage createState()=>_NotificationPage();
}

class _NotificationPage extends State<NotificationPage>{

  List<CommentModel> arrNotification=[];

  int page=0;

  bool isLast=false;
  bool isLoading=true;

  @override
  void initState() {
    super.initState();
    getNotification();
  }

  getNotification() async {
    if(isLast){
      return;
    }
   try {
     var response = await RequestApi.get('notification/parent?page=$page&size=20');

     if (response != null) {
        var js = json.decode(response);
        var currentPage=js['currentPage'];
        var numberOfPages=js['numberOfPages'];
        isLast = numberOfPages==(currentPage+1);
        var list = (js['content'] as List).map((e) => CommentModel.fromJSON(e)).toList();
        setState(() {
          isLoading=false;
          arrNotification.addAll(list);
        });
      }
    } catch(_) {
      setState(() {
        isLoading=false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PsColors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45,left: 15,right: 15,bottom: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                        Navigator.pop(context);

                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: PsColors.mainColor,
                    )
                ),
                Expanded(child:const SizedBox()),


              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'notification'.tr,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                          color: PsColors.mainColor
                      ),
                      textAlign: TextAlign.center,
                    ),


                    const SizedBox(
                      height: 30,
                    ),

                    Wrap(
                      children:arrNotification.map((e) => NotificationView(e,'')).toList()
                    ),
                    isLoading?Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ):const SizedBox(),

                    !isLoading && arrNotification.length==0?Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Text(
                          'There are no notification yet.',
                          style: GoogleFonts.notoSans(
                            fontSize: 17,
                            color: PsColors.markColor,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ):const SizedBox()


                  ],
                ),
              ),
            ),
          ),




        ],
      ),
    );
  }

  Widget socail(String image){

    return Container(
      height: 46,
      width: 46,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: PsColors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        image,
        color: PsColors.mainColor,
      ),
    );
  }
}