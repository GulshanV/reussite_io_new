class ScheduleModel{

  dynamic id;
  dynamic createDate;
  dynamic startDate;
  dynamic endDate;
  dynamic courseId;
  dynamic durationInMinutes;
  dynamic repeatPeriodInDays;

  ScheduleModel.empty(){}

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

  }


  List<ScheduleModel> arrMultiTime=[];

}