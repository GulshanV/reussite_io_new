import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reussite_io_new/config/ps_color.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/model/comment_model.dart';
import 'package:reussite_io_new/services/request_api.dart';
import 'package:reussite_io_new/ui/notification/notification_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentSection extends StatefulWidget{

  @override
  _CommentSection createState()=>_CommentSection();
}
class _CommentSection extends State<CommentSection>{

  List<CommentModel> arrComments=[];

  int page=0;

  bool isLast=false;
  bool isLoading=true;

  String parentId;
  String bookingId;
  String subject;
  String stdId;
  String stdFirstName;
  String stdLastName;

  @override
  void initState() {
    super.initState();
    getLoginData();

  }
  AuthModel user;

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response= prefs.getString('login');
    var js=json.decode(response);
    user = AuthModel.fromJson(js);
    getData();
  }

  getData(){
    var arg=Get.arguments;
    parentId= user.id;
    bookingId=arg['id'];
    subject=arg['subject'];
    stdId=arg['stdId'];
    stdFirstName=arg['stdFirstName'];
    stdLastName=arg['stdLastName'];

    getNotification();
  }

  getNotification() async {
    if(isLast){
      return;
    }
    try {
      var response = await RequestApi.get('comment?bookingId=$bookingId&page=0&parentId=$parentId&size=20');

      if (response != null) {
        var js = json.decode(response);
        var currentPage=js['currentPage'];
        var numberOfPages=js['numberOfPages'];
        isLast = numberOfPages==(currentPage+1);
        var list = (js['content'] as List).map((e) => CommentModel.fromJSON(e)).toList();
        setState(() {
          isLoading=false;
          arrComments.addAll(list);
        });
      }
    } catch(_) {
      setState(() {
        isLoading=false;
      });
    }
  }

  sendMsg() async {

    try {
      var map={
        "content": commentTextController.text,
        "studentBooking": {
          "id": bookingId
        },
        "studentParent": {
          "id": parentId
        },
        "studentProfile": {
          "firstName": stdFirstName,
          "id": stdId,
          "lastName": stdLastName
        }
      };
      setState(() {
        commentTextController.text='';
      });
      var response = await RequestApi.postAsync('comment',body:map);
       print(response);
      if (response != null) {
        getNotification();
      }
    } catch(_) {
      print(_);
    }
  }

  TextEditingController commentTextController= TextEditingController();


  @override
  Widget build(BuildContext context) {

     return Scaffold(
       body: Column(
         children: [
           Padding(
             padding: const EdgeInsets.only(top: 40,left: 15,right: 15,bottom: 10),
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
             child: SingleChildScrollView(
               reverse: true,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Wrap(
                       children:arrComments.map((e) => NotificationView(e,subject)).toList()
                   ),
                   isLoading?Padding(
                     padding: const EdgeInsets.all(30.0),
                     child: Center(
                       child: CircularProgressIndicator(),
                     ),
                   ):const SizedBox(),

                   !isLoading && arrComments.length==0?Padding(
                     padding: const EdgeInsets.all(30.0),
                     child: Center(
                       child: Text(
                         'There are no comments yet.',
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

     /*      Container(
             color:Colors.white,
             padding: const EdgeInsets.all(10),
             child: Container(
               decoration: BoxDecoration(
                 border: Border.all(
                   color: PsColors.light_grey,
                   width: 1
                 ),
                 borderRadius: BorderRadius.circular(15)
               ),
               child: TextField(
                 controller: commentTextController,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   contentPadding: const EdgeInsets.all(15),
                   hintText: 'Add your comment',
                   hintStyle: GoogleFonts.notoSans(
                     fontWeight: FontWeight.w400,
                     fontSize: 15,
                     color: PsColors.disableColor
                   ),
                   suffixIcon: InkWell(
                     onTap: (){
                        if(commentTextController.text.isEmpty){

                        }else{
                           sendMsg();
                        }
                     },
                     child: Icon(
                       Icons.send,
                       color: PsColors.mainColor,
                       size: 25,
                     ),
                   )
                 ),
                 minLines: 1,
                 maxLines: 4,
                 style: GoogleFonts.notoSans(
                       fontWeight: FontWeight.w400,
                       fontSize: 15,
                       color: PsColors.black
                   )
               ),
             ),
           )*/
         ],
       ),
     );
  }
}

