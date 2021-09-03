import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/model/booking_model.dart';
import 'package:reussite_io_new/model/course_model.dart';
import 'package:reussite_io_new/model/image_model.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/services/cqapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils.dart';

class HomeController extends GetxController{


  var arrStudent = List<Student>().obs;
  var arrBooking = List<BookingModel>().obs;
  var isLoading=true.obs;

  AuthModel user;

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response= prefs.getString('login');
    var js=json.decode(response);
    user = AuthModel.fromJson(js);
    getChildList();
  }

  getChildList() async {

    try {
      isLoading(true);
      var value = await CQAPI.getMyChild(
          id:  user.id
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response= prefs.getString('image');
      print(response);
      if(response != null){
        var js=json.decode(response);
        List<ImageModel> arrImage=(js as List).map((e) => ImageModel.fromJSON(e)).toList();

        for(var mmm in value){
          for(int i=0;i<arrImage.length;i++){
            if(mmm.id==arrImage[i].childId){
              value[i].imagePath=arrImage[i].image;
            }
          }
        }
      }

      arrStudent(value);
      if(value.length>0){
        getSlot();
      }
    } finally {
      isLoading(false);
    }


  }



  var arrAvailableSlot=List<ScheduleModel>().obs;
  var arrAllSchedule=List<ScheduleModel>().obs;



  Future<void> getSlot() async {
    var grade=[];
    arrStudent.map((element) => grade.add(element.grade));
    final newList = grade.toSet().toList();
    final gr=newList.join('grade&');
    var grad = 'grade&$gr';
    var value = await CQAPI.getScheduleAll(grad);

    List<ScheduleModel> data=[];
    for(var model in value){
      int isIndex=-1;
      bool alreadyExists=false;
      for(int index=0;index<data.length;index++){
        String parent=model.startDate.toString().split(' ')[0];
        String child=data[index].startDate.toString().split(' ')[0];
        if(parent==child &&
           model.startDate== data[index].startDate &&
            model.course.name== data[index].course.name
        ){
          isIndex=index;
          alreadyExists=true;
        }
      }
      if(!alreadyExists){
      if(isIndex==-1){
        ScheduleModel m = ScheduleModel.empty();
        m.startDate= model.startDate;
        m.id= model.id;
        m.course= model.course;
        m.arrMultiTime.add(model);
        data.add(m);
      }else{
        data[isIndex].arrMultiTime.add(model);
      }
    }}

    arrAllSchedule(data);
    isLoading(false);
  }

  clearSlot(){
    List<ScheduleModel> arrMultiTime=[];
    arrAvailableSlot(arrMultiTime);
  }

  selectAvalibleSlot(String index){
    print("Pavan $index");
    int i=int.parse(index);
    var model=arrAllSchedule[i].arrMultiTime;

    arrAvailableSlot(model);

  }


  var isLoadingSlot=false.obs;
  getBookingListChildId({bool isCallBooking=false}) async {

    try {
      String id = arrStudent[index.value].id;
      isLoadingSlot(true);
      var value = await CQAPI.getBookingListChildId(id);
      List<BookingModel> list=[];
      for(var m in value){
        int isExists=-1;
        var d= m.schedule.startDate.toString().split(' ')[0];
          for(int i=0;i<list.length;i++){
              if(list[i].compareDate==d){
                isExists=i;
                break;
              }
          }
        if(isExists==-1){
          BookingModel mm=BookingModel.empty();
          mm.compareDate=d;
          mm.startDate=m.schedule.startDate;
          mm.arrAllBooking.add(m);
          list.add(mm);
        }else{
          list[isExists].arrAllBooking.add(m);
        }
      }

      for(var model in arrAllSchedule){
        int isIndex=-1;
        String parent=model.startDate.toString().split(' ')[0];
        for(int index=0;index<list.length;index++){

          String child=list[index].startDate.toString().split(' ')[0];
          if(parent==child){
            isIndex=index;
          }
        }

        for(var mmm in model.arrMultiTime){
          BookingModel nbModel=BookingModel.empty();
          var sM=ScheduleModel.empty();
          sM.startDate=mmm.startDate;
          sM.course=mmm.course;
          sM.id= mmm.id;
          sM.course.name=mmm.course.subject.name;
          nbModel.schedule=sM;
          nbModel.isBooking=false;

          if(isIndex==-1){
            BookingModel mm=BookingModel.empty();
            mm.isBooking=false;
            mm.compareDate=parent;
            mm.startDate=mmm.startDate;
            mm.arrAllBooking.add(nbModel);
            list.add(mm);
          }else{
            list[isIndex].arrAllBooking.add(nbModel);
          }
        }


      }

      arrBooking(list);

    } finally {
      isLoadingSlot(false);
    }

    // if(isCallBooking){
    //   getChildList();
    // }
  }

  var index=10001.obs;

  void changeIndex(int i) {
    index(i);
    if(i!=10001){
      getBookingListChildId();
    }else{
      isLoadingSlot(true);
      List<BookingModel> list=[];
      arrBooking(list);
      arrSubjectList(list);
      isLoadingSlot(false);
    }

  }

  clearSubject(){
    List<BookingModel> list=[];
    arrSubjectList(list);
  }


  var arrSubjectList = List<BookingModel>().obs;

  void selectEvent(String position) {
    int index=int.parse(position);
    List<BookingModel> arrList=[];

    for(var m in arrBooking[index].arrAllBooking){
       bool isExists=false;
       for(int i =0;i<arrList.length;i++){
         if(
         m.startDate== arrList[i].startDate &&
         m.schedule.course.name== arrList[i].schedule.course.name){
           isExists=true;
         }
       }

       if(!isExists){
         arrList.add(m);
       }
    }

    arrSubjectList(arrList);
  }
//  booking?profileId=
// page=0&size=20&startDate=01%2F01%2F2010%2000%3A00%3A00%20-0500

  addReservation(Course course, ScheduleModel schedule,String descripton) async {
    if(course==null){
      Utils.errorToast('select_booking_course'.tr);
    }else if(schedule==null){
      Utils.errorToast('select_booking_schedule'.tr);
    }else{
      var subject={
        'id':course.subject.id,
        'name':course.subject.name
      };
      var courseMap={
        'name':course.name,
        'description':descripton??'',
        'subject':subject,
      };
      var scheduleMap={
        'course':courseMap,
        'id':schedule.id
      };
      var studentProfileMap={
        'id':arrStudent[index.value].id
      };
      var map={
        'studentProfile':studentProfileMap,
        'schedule':scheduleMap
      };
      try {

        var value = await CQAPI.newBooking(map );
        if(value!=null){
          Map js = json.decode(value);
          var model=BookingModel.fromJSON(js);
          if(js.containsKey('id')){
            List<BookingModel> list=[];
            arrSubjectList(list);
            getBookingListChildId();

          }
        }

      } finally {

      }
    }


  }




}