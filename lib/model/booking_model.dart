import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/model/student.dart';

class BookingModel{

  dynamic id;
  dynamic createDate;
  Student student;
  ScheduleModel schedule;
  dynamic lastUpdateDate;

  BookingModel.empty(){

  }

  BookingModel.fromJSON(Map<String,dynamic> map){
    id=map['id'];
    createDate=map['createDate'];
    lastUpdateDate=map['lastUpdateDate'];
    student =Student.fromDetails(map['studentProfile']);
    schedule =ScheduleModel.fromJSON(map['schedule']);
  }

  String startDate;
  String compareDate;
  List<BookingModel> arrAllBooking=[];
}