import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reussite_io_new/model/booking_model.dart';
import 'package:reussite_io_new/model/course_model.dart';
import 'package:reussite_io_new/model/parent_model.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/services/request_api.dart';

class CQAPI {
  static var client = http.Client();

  static Future<String> login({String mobile,String dialCode}) async {
    String phone = mobile
        .replaceAll('-', '');
        // .replaceAll(' ', '')
        // .replaceAll('(', '')
        // .replaceAll(')', '');
    var map={
      'phoneNumber':phone,
      'countryCode':dialCode
    };
    var response = await RequestApi.postAsync('parent',body: map);
    print(response);

    return response;
  }

  static Future<Student> getChildInformation(String studentId) async {
    var response = await RequestApi.get('student/$studentId');
    print(response);
    Student student;
    if (response != null) {
      var js = json.decode(response);
      student = Student.fromJSON(js);
    }

    return student;
  }

  static Future<String> verifyOTP(String parentId,String code) async {
    String res;
   try{

     var url = 'parent/activate/$parentId?activationCode=$code';
     // var url = 'parent/activation/$parentId?activationCode=$code';
     var response = await RequestApi.get(url);
     Map js=json.decode(response);
     if(js.containsKey('access_token')){
       res=response;
     }
   }catch(_){
     print(_);
   }
    return res;
  }

  static Future<List<ScheduleModel>> getScheduleCourseId(String id) async {
    var response = await RequestApi.get('schedule?courseId=$id');
    print(response);
    List<ScheduleModel> list = [];
    if (response != null) {
      var js = json.decode(response);
      list = (js['content'] as List)
          .map((e) => ScheduleModel.fromJSON(e))
          .toList();
    }

    return list;
  }


  static Future<List<ScheduleModel>> getScheduleAll(String grade) async {
    DateTime currnt=DateTime.now().add(Duration(days: -1));
    var s=DateFormat('MM/dd/yyyy').format(currnt);
    var startSch='&startDate=$s 00:00:00 -0500';
    // 01/01/2010

    var url ='schedule?size=300$startSch';
    if(grade.length>0){
      url=url+'&grades=$grade';
    }
    var response = await RequestApi.get(url);
    print(response);
    List<ScheduleModel> list = [];
    if (response != null) {
      var js = json.decode(response);
      list = (js['content'] as List)
          .map((e) => ScheduleModel.fromJSON(e))
          .toList();
    }

    return list;
  }

  static Future<ParentModel> getParentProfile({dynamic id}) async {
    var response = await RequestApi.get('parent/$id');

    ParentModel parentModel;

    try {
      print(response);
      if (response != null) {
        var js = json.decode(response);
        parentModel= ParentModel.fromJSON(js);
      }
    } finally {}
    return parentModel;
  }

  static Future<List<Student>> getMyChild({dynamic id}) async {
    var response = await RequestApi.get('student?parentId=$id');
    List<Student> list = [];

    try {
      print(response);
      if (response != null) {
        var js = json.decode(response);
        list = (js['content'] as List).map((e) => Student.fromJSON(e)).toList();
      }
    } finally {}
    return list;
  }


  static Future<List<Course>> getAllCourseList() async {
    var response = await RequestApi.get('course?size=100');
    print(response);
    List<Course> list = [];
    if (response != null) {
      var js = json.decode(response);
      list = (js['content'] as List).map((e) => Course.fromJSON(e)).toList();
    }

    return list;
  }
  static Future<List<BookingModel>> getBookingListChildId(String childId) async {
    var response = await RequestApi.get('booking?profileId=$childId');
    print(response);
    List<BookingModel> list = [];
    if (response != null) {
      var js = json.decode(response);
      list = (js['content'] as List).map((e) => BookingModel.fromJSON(e)).toList();
    }
    return list;
  }

  static Future<String> getChildDetails({dynamic id}) async {
    var response = await RequestApi.get('student/$id');
    print(response);

    return null;
  }

  static Future<Student> addNewChild(
      String parentId,
      String name,
      String school,
      String board,
      String level,
      String phone,
      String email,
      String dailCode
      ) async {
    String mobile = phone
        .replaceAll('-', '')
        .replaceAll(' ', '')
        .replaceAll('(', '')
        .replaceAll(')', '');

    String fName = '';
    String lastName = '';
    var arr = name.split(' ');
    if (arr.length > 1) {
      fName = arr[0];
      lastName = arr[1];
    } else {
      fName = name;
    }

    var map = {
      "email": email,
      "firstName": fName,
      "grade": level,
      "lastName": lastName,
      "studentParentId": parentId,
      "schoolBoard": board,
      "schoolName": school,
      "phoneNumber": mobile,
      "countryCode": dailCode
    };

    var response = await RequestApi.postAsync('student', body: map);
    print(response);
    Student student;
    if (response != null) {
      var js = json.decode(response);
      student = Student.fromJSON(js);
    }

    return student;
  }

  static Future<String> newBooking(Map map) async {
    var response = await RequestApi.postAsync('booking', body: map);
    print(response);

    return response;
  }

  static Future<Student> updateChild(
      String studentId,
      String parentId,
      String name,
      String school,
      String board,
      String level,
      String phone,
      String countryCode,
      String email) async {
    String mobile = phone
        .replaceAll('-', '')
        .replaceAll(' ', '')
        .replaceAll('(', '')
        .replaceAll(')', '');

    String fName = '';
    String lastName = '';
    var arr = name.split(' ');
    if (arr.length > 1) {
      fName = arr[0];
      lastName = arr[1];
    } else {
      fName = name;
    }

    var map = {
      "email": email,
      "firstName": fName,
      "grade": level,
      "lastName": lastName,
      "countryCode": countryCode.replaceAll('+', ''),
      "phoneNumber": mobile,
      "studentParentId": parentId,
      "schoolBoard": board,
      "schoolName": school
    };
    print(map);

    Student student;
    var response = await RequestApi.patch('student/$studentId', body: map);

    print(response);
    if(response!=null){
      var js = jsonDecode(response);
      student= Student.fromJSON(js);
    }

    return student;
  }

  static Future<ParentModel> updateParent(
      String parentId,
      String name,
      String email,
      String language,
      String phone) async {
    String mobile = phone
        .replaceAll('-', '')
        .replaceAll(' ', '')
        .replaceAll('(', '')
        .replaceAll(')', '');

    String fName = '';
    String lastName = '';
    var arr = name.split(' ');
    if (arr.length > 1) {
      fName = arr[0];
      lastName = arr[1];
    } else {
      fName = name;
    }

    var map = {
      "email": email,
      "firstName": fName,
      "lastName": lastName,
      "phoneNumber": mobile,
      "id": parentId,
      "language": language,

    };
    print(map);

    ParentModel student;
    var response = await RequestApi.patch('parent/$parentId', body: map);
    print(response);
    if(response!=null){
      var js = jsonDecode(response);
      student= ParentModel.fromJSON(js);
    }

    return student;
  }
}
