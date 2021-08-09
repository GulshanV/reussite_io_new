class ScheduleModel{

  dynamic id;
  dynamic createDate;
  dynamic startDate;
  dynamic endDate;
  dynamic courseId;
  dynamic repeatPeriodInDays;

  ScheduleModel.empty(){}

  ScheduleModel.fromJSON(Map<String,dynamic> map){
    id=map['id'];
    createDate=map['createDate'];
    startDate=map['startDate'];
    endDate=map['endDate'];
    courseId=map['courseId'];
    repeatPeriodInDays=map['repeatPeriodInDays'];
  }


  List<ScheduleModel> arrMultiTime=[];

}