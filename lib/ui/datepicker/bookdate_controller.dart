import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
import 'package:reussite_io_new/services/cqapi.dart';

class BookDateController  extends GetxController{

  var arrSchedule=List<ScheduleModel>().obs;
  var isLoading=true.obs;



  Future<void> getSlot() async {
    var childId = Get.arguments['id'];
    var value = await CQAPI.getScheduleCourseId(childId);

    List<ScheduleModel> data=[];
    for(var model in value){
       int isIndex=-1;

       for(int index=0;index<model.arrMultiTime.length;index++){
          String parent=model.startDate.toString().split(' ')[0];
          String child=model.arrMultiTime[index].startDate.toString().split(' ')[0];
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

    arrSchedule(data);
    isLoading(false);
  }

  var arrSlot=List<ScheduleModel>().obs;

  clearSlot(){
    List<ScheduleModel> arrMultiTime=[];
    arrSlot(arrMultiTime);
  }

  selectEvent(String index){
    int i=int.parse(index);
    var model=arrSchedule[i].arrMultiTime;

    arrSlot(model);

  }






}