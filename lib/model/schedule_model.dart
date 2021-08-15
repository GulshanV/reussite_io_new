import 'course_model.dart';

class ScheduleModel{

  dynamic id;
  dynamic createDate;
  dynamic startDate;
  dynamic endDate;
  dynamic courseId;
  dynamic durationInMinutes;
  dynamic repeatPeriodInDays;

  ScheduleModel.empty(){}

  Course course;

  ScheduleModel.fromJSON(Map<String,dynamic> map){
    id=map['id'];
    createDate=map['createDate'];
    startDate=map['startDate'];
    endDate=map['endDate'];
    courseId=map['courseId'];
    if(map.containsKey('durationInMinutes')){
      durationInMinutes=map['durationInMinutes'];
    }else{
      repeatPeriodInDays=map['repeatPeriodInDays'];
    }

    course=Course.fromBooking(map['course']);

  }


  List<ScheduleModel> arrMultiTime=[];

}