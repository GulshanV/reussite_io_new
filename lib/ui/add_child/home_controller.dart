import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/services/cqapi.dart';

class HomeController extends GetxController{


  var arrStudent = List<Student>().obs;
  var isLoading=true.obs;

  getChildList() async {

    try {
      isLoading(true);
      var value = await CQAPI.getMyChild(
          id: '8a0080277ae7d1d0017ae7e502a10023'
      );
      arrStudent(value);
    } finally {
      isLoading(false);
    }
  }

  var index=0.obs;

  void changeIndex(int i) {
    index(i);
  }


}