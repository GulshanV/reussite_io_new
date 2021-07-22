import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/repositry/repository_adapter.dart';

class AuthController extends SuperController<AuthModel>{
  AuthController({@required this.homeRepository});

  final IAuthRepository homeRepository;
  @override
  void onInit() {
    super.onInit();
    append(() => homeRepository.getCases);
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