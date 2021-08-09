import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/repositry/repository_adapter.dart';
import 'package:reussite_io_new/services/cqapi.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AuthController extends SuperController<AuthModel>{

  var loginProcess = false.obs;
  var error = "";

  var otpInvalid=false.obs;

 String otpValid(String otp){
   print(otp);
   if(otp.length<4){
     otpInvalid(true);
     return null;
   }else if(otp=='3232'){
      otpInvalid(true);
      return 'otp is required';
    }else{
      otpInvalid(true);
      return "invalid";
    }


  }

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

  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }



  validationCreateStudent(String name,String school,String board,String level,String phone,String email) async {
    print('fullname: $name');
    if(name.isEmpty){
      errorMsg('full_name_required'.tr);
    }else if(name.length<3){
      errorMsg('full_name_min_length_error'.tr);
    }else if(school.isEmpty){
      errorMsg('school_required'.tr);
    }else if(board.isEmpty){
      errorMsg('board_required'.tr);
    }else if(level.isEmpty){
      errorMsg('level_required'.tr);
    }else  if(phone.length<9){
      errorMsg('invalid_mobile_no'.tr);
    }else  if(email.isEmpty){
      errorMsg('email_required'.tr);
    }else  if(validateEmail(email)){
      errorMsg('email_invalid'.tr);
    }else {
      error = "";
      try {
        loginProcess(true);
        Student loginResp = await CQAPI.addNewChild(
          '8a0080277ae7d1d0017ae7e502a10023',
            name,
            school,
            board,
            level,
            phone,
            email
        );
        if(loginResp!=null){
          Get.back(result: loginResp);
        }
      } finally {
        loginProcess(false);
      }
      return error;
    }
  }



  validationUpdateStudent(String name,String school,String board,String level,String phone,String email) async {
    print('fullname: $name');
    if(name.isEmpty){
      errorMsg('full_name_required'.tr);
    }else if(name.length<3){
      errorMsg('full_name_min_length_error'.tr);
    }else if(school.isEmpty){
      errorMsg('school_required'.tr);
    }else if(board.isEmpty){
      errorMsg('board_required'.tr);
    }else if(level.isEmpty){
      errorMsg('level_required'.tr);
    }else  if(phone.length<9){
      errorMsg('invalid_mobile_no'.tr);
    }else  if(email.isEmpty){
      errorMsg('email_required'.tr);
    }else  if(validateEmail(email)){
      errorMsg('email_invalid'.tr);
    }else {
      error = "";
      try {
        loginProcess(true);
        dynamic loginResp = await CQAPI.updateChild(
            '8a0080277ae7d1d0017ae7e502a10023', //StudentId
            '8a0080277ae7d1d0017ae7e502a10023',//ParentId
            name,
            school,
            board,
            level,
            phone,
            email
        );

      } finally {
        loginProcess(false);
      }
      return error;
    }
  }



  errorMsg(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static bool validateEmail(String value) {

    String emailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(emailPattern);
    return regExp.hasMatch(value);
  }
}