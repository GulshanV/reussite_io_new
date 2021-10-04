import 'dart:convert';

import 'package:get/get.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/model/course_model.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/services/cqapi.dart';
import 'package:reussite_io_new/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReservationController extends SuperController<AuthModel> {
  var index = 0.obs;

  var childLoadProcess = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLoginData();
  }

  AuthModel user;

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = prefs.getString('login');
    var js = json.decode(response);
    user = AuthModel.fromJson(js);

    // getChildList();
    // getAllCoure();
  }

  var isBack = false.obs;

  addReservation(Student student, Course course, ScheduleModel schedule,
      String descripton) async {
    if (student == null) {
      Utils.errorToast('child_a_child'.tr);
    } else if (course == null) {
      Utils.errorToast('select_booking_course'.tr);
    } else if (schedule == null) {
      Utils.errorToast('select_booking_schedule'.tr);
    } else {
      var subject = {'id': course.subject.id, 'name': course.subject.name};
      var courseMap = {
        'name': course.name,
        'description': descripton ?? '',
        'subject': subject,
      };
      var scheduleMap = {'course': courseMap, 'id': schedule.id};
      var studentProfileMap = {'id': student.id};
      var map = {'studentProfile': studentProfileMap, 'schedule': scheduleMap};
      try {
        isBack(true);
        var value = await CQAPI.newBooking(map);

        if (value != null) {
          Utils.errorToast('booking_created_successfully'.tr);
          Map js = json.decode(value);
          if (js.containsKey('id')) {
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
