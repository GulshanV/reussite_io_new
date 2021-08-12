import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/services/cqapi.dart';

class UpdateChildController extends GetxController {
  var isLoadInformation = true.obs;
  var student = Student.empty().obs;

  Future<void> getChildInformation() async {
    var childId = Get.arguments['id'];
    var value = await CQAPI.getChildInformation(childId);
    student(value);
    isLoadInformation(false);
  }

  var isEdit = false.obs;

  edit() {
    isEdit(!isEdit.value);
  }

  Future<void> updateChildInformation(var studentId, var parentId, var name,
      var school, var board, var level, var phone, var email) async {
    var value = await CQAPI.updateChild(
        studentId, parentId, name, school, board, level, phone, email);
    isLoadInformation(false);
  }
}
