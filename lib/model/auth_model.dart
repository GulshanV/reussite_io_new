import 'package:reussite_io_new/model/student.dart';

class AuthModel{
  dynamic id;
  dynamic email;
  dynamic phoneNumber;
  dynamic createDate;
  dynamic language;
  dynamic countryCode;
  dynamic lastUpdateDate;
  dynamic firstName;


  AuthModel.fromJson(Map<String, dynamic> map) {
    id=map['id'];
    email=map['email'];
    phoneNumber=map['phoneNumber'];
    createDate=map['createDate'];
    language=map['language'];
    countryCode=map['countryCode'];
    lastUpdateDate=map['lastUpdateDate'];
    if(map.containsKey('firstName')){
      firstName=map['firstName'];
    }
  }


  Student student;


}