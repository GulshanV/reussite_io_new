import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reussite_io_new/model/booking_model.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/services/cqapi.dart';

class HomeController extends GetxController{


  var arrStudent = List<Student>().obs;
  var arrBooking = List<BookingModel>().obs;
  var isLoading=true.obs;

  getChildList() async {

    try {
      isLoading(true);
      var value = await CQAPI.getMyChild(
          id: '8a0081917b3f334d017b3f4cbe480023'
      );
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
    var value = await CQAPI.getScheduleAll();

    List<ScheduleModel> data=[];
    for(var model in value){
      int isIndex=-1;

      for(int index=0;index<data.length;index++){
        String parent=model.startDate.toString().split(' ')[0];
        String child=data[index].startDate.toString().split(' ')[0];
        if(parent==child){
          isIndex=index;
        }
      }
      if(isIndex==-1){
        ScheduleModel m = ScheduleModel.empty();
        m.startDate= model.startDate;
        m.arrMultiTime.add(model);
        data.add(m);
      }else{
        data[isIndex].arrMultiTime.add(model);
      }
    }

    arrAllSchedule(data);
    isLoading(false);
  }

  clearSlot(){
    List<ScheduleModel> arrMultiTime=[];
    arrAvailableSlot(arrMultiTime);
  }

  selectAvalibleSlot(String index){
    int i=int.parse(index);
    var model=arrAllSchedule[i].arrMultiTime;

    arrAvailableSlot(model);

  }


  var isLoadingSlot=false.obs;
  getBookingListChildId() async {

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

      arrBooking(list);

    } finally {
      isLoadingSlot(false);
    }
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
    arrSubjectList(arrBooking[index].arrAllBooking);
  }
//  booking?profileId=
// page=0&size=20&startDate=01%2F01%2F2010%2000%3A00%3A00%20-0500


}