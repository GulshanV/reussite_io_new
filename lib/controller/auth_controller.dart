import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/repositry/repository_adapter.dart';
import 'package:reussite_io_new/services/cqapi.dart';

class AuthController extends SuperController<AuthModel>{

  var loginProcess = false.obs;
  var error = "";

  Future<String> login({String phone}) async {
    error = "";
    try {
      loginProcess(true);
      dynamic loginResp = await CQAPI.login(mobile: phone);

    } finally {
      loginProcess(false);
    }
    return error;
  }


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    print('The build method is done. '
        'Your controller is ready to call dialogs and snackbars');
    super.onReady();
  }


  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

}