
import 'package:get/get.dart';
import 'package:reussite_io_new/model/parent_model.dart';
import 'package:reussite_io_new/services/cqapi.dart';

class ProfileController extends GetxController{

  var childLoadProcess=true.obs;

  var model=ParentModel.empty().obs;

  Future<void> getParentDetails() async {
    try {
      childLoadProcess(true);
      var value = await CQAPI.getParentProfile(
          id: '8a0080277ae7d1d0017ae7e502a10023'
      );
      model(value);
    } finally {
      childLoadProcess(false);
    }
  }

}