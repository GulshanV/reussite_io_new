import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/model/course_model.dart';
import 'package:reussite_io_new/model/course_selection_model.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/repositry/repository_adapter.dart';
import 'package:reussite_io_new/services/cqapi.dart';
import 'package:reussite_io_new/utils.dart';

class AddReservationController extends SuperController<AuthModel>{


  var arrStudent = List<Student>().obs;
  var arrCourseList =List<CourseSelectionModel>().obs;

  var index=0.obs;

  var childLoadProcess = false.obs;

  @override
  void onInit() {
    super.onInit();
    getChildList();
    getAllCoure();
  }


   getChildList() async {

    try {
      childLoadProcess(true);
      var value = await CQAPI.getMyChild(
        id: '8a0081917b3f334d017b3f4cbe480023'
      );
      arrStudent(value);
    } finally {
      childLoadProcess(false);
    }
    // notifyChildrens();
  }


   getAllCoure() async {

    try {
      childLoadProcess(true);
      List<Course> value = await CQAPI.getAllCourseList();

      for(var m in value){
        int isExist=-1;
        for(int i=0;i<arrCourseList.length;i++){
           if(m.subject.name==arrCourseList[i].courseName){
             isExist=i;
             break;
           }
        }
        if(isExist==-1){
          var coursM=CourseSelectionModel();
          coursM.arrCourse.add(m);
          coursM.courseName=m.subject.name;
          arrCourseList.add(coursM);
        }else{
          arrCourseList[isExist].arrCourse.add(m);
        }
      }


    } finally {
      childLoadProcess(false);
    }
    // notifyChildrens();
  }


   var isBack=false.obs;


  addReservation(Student student,Course course, ScheduleModel schedule,String descripton) async {
    if(student==null){
      Utils.errorToast('child_a_child'.tr);
    }else if(course==null){
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
        'id':student.id
      };
      var map={
        'studentProfile':studentProfileMap,
        'schedule':scheduleMap
      };
      try {
        isBack(true);
        var value = await CQAPI.newBooking(map );
        if(value!=null){
          Map js = json.decode(value);
          if(js.containsKey('id')){
            Get.back(result: true);
          }
        }
        isBack(false);
      } finally {
        isBack(false);
      }
    }


  }



  @override
  void onReady() {
    super.onReady();
  }


  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  void changeIndex(int index) {
     this.index(index);
  }

}