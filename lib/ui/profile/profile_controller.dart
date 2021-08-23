
import 'package:get/get.dart';
import 'package:reussite_io_new/model/parent_model.dart';
import 'package:reussite_io_new/services/cqapi.dart';

import '../../utils.dart';

class ProfileController extends GetxController{

  var childLoadProcess=true.obs;

  var model=ParentModel.empty().obs;

  Future<void> getParentDetails() async {
    try {
      childLoadProcess(true);
      var value = await CQAPI.getParentProfile(
          id: '8a0081917b3f334d017b3f4cbe480023'
      );
      model(value);
    } finally {
      childLoadProcess(false);
    }
  }

  Future<void> updateProfile(var name,var phone, var email) async {

    var value = await CQAPI.updateParent(
      '8a0081917b3f334d017b3f4cbe480023',
        name,
      email,
        'en',
        phone);
    if(value!=null){
      var m = model.value;
      String fName = '';
      String lastName = '';
      var arr = name.split(' ');
      if (arr.length > 1) {
        fName = arr[0];
        lastName = arr[1];
      } else {
        fName = name;
      }
      m.firstName=fName;
      m.lastName = lastName;
      m.email=email;
      m.phoneNumber=phone;
      model(m);
      Utils.successToast('Profile update successfully');
      Get.back(result: true);
    }

  }

}