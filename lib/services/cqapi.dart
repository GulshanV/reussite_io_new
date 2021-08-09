import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reussite_io_new/model/course_model.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/services/request_api.dart';

class CQAPI {
  static var client = http.Client();


  static Future<String> login({String mobile}) async {
   String phone = mobile.replaceAll('-', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', '');
    var response = await RequestApi.get('parent/phoneNumber/$phone');
    print(response);

    return response;

  }

  static Future<Student> getChildInformation(String studentId) async {
    var response = await RequestApi.get('student/$studentId');
    print(response);
    Student student;
    if(response!=null){
      var js = json.decode(response);
      student=Student.fromJSON(js);
    }

    return student;

  }
  static Future<List<ScheduleModel>> getScheduleCourseId(String id) async {
    var response = await RequestApi.get('schedule?courseId=$id');
    print(response);
    List<ScheduleModel> list=[];
    if(response!=null){
      var js = json.decode(response);
      list=(js['content'] as List).map((e) => ScheduleModel.fromJSON(e)).toList();
    }

    return list;

  }

  static Future<List<Student>> getMyChild({dynamic id}) async {
    var response = await RequestApi.get('student?parentId=$id');
    List<Student> list = [];
    if(response!=null){
      var js = json.decode(response);
      list=(js['content'] as List).map((e) => Student.fromJSON(e)).toList();
    }

    return list;

  }
  static Future<List<Course>> getAllCourseList() async {
    var response = await RequestApi.get('course');
    print(response);
    List<Course> list = [];
    if(response!=null){
      var js = json.decode(response);
      list=(js['content'] as List).map((e) => Course.fromJSON(e)).toList();
    }

    return list;

  }

  static Future<String> getChildDetails({dynamic id}) async {
    var response = await RequestApi.get('student/$id');
    print(response);

    return null;

  }
  static Future<Student> addNewChild(String parentId,String name,String school,String board,String level,String phone,String email) async {
   String mobile = phone.replaceAll('-', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', '');

   String fName='';
   String lastName='';
   var arr= name.split(' ');
   if(arr.length>1){
     fName=arr[0];
     lastName=arr[0];
   }else{
     fName=name;
   }

   var map={
     "email": email,
     "firstName": fName,
     "grade": level,
     "lastName": lastName,
     "parentId": parentId,
     "schoolBoard": board,
     "schoolName": school,
     "phone": mobile
   };

    var response = await RequestApi.postAsync('student',body: map);
    print(response);
   Student student;
    if(response!=null){
      var js = json.decode(response);
      student=Student.fromJSON(js);
    }

    return student;

  }

  static Future<String> updateChild(String studentId,String parentId,String name,String school,String board,String level,String phone,String email) async {
    String mobile = phone.replaceAll('-', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', '');

    String fName='';
    String lastName='';
    var arr= name.split(' ');
    if(arr.length>1){
      fName=arr[0];
      lastName=arr[0];
    }else{
      fName=name;
    }

    var map={
      "email": email,
      "firstName": fName,
      "grade": level,
      "lastName": lastName,
      "parentId": parentId,
      "schoolBoard": board,
      "schoolName": school
    };

    var response = await RequestApi.putAsync('student/$studentId',body: map);
    print(response);

    return null;

  }





}