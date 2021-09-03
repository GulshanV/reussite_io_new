import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/model/student.dart';
import 'package:reussite_io_new/routes/app_routes.dart';
import 'package:reussite_io_new/services/cqapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class AuthController extends SuperController<AuthModel> {
  var loginProcess = false.obs;
  var error = "";

  var otpInvalid = false.obs;

  AuthModel auth;

  void resendOTP() {
    if (auth == null) {
      var res = Get.arguments['data'];
      print(res);
      var js = json.decode(res);
      auth = AuthModel.fromJson(js);
    }
    login(phone: auth.phoneNumber, dialCode: '${auth.countryCode}');
  }

  Future<String> otpValid(String otp) async {
    print(otp);

    var res = Get.arguments['data'];
    print(res);
    var js = json.decode(res);
    auth = AuthModel.fromJson(js);

    if (otp.length < 4) {
      otpInvalid(true);
      return 'otp is required';
    } else if (otp.length == 4) {
      loginProcess(true);
      var value = await CQAPI.verifyOTP(auth.id, otp);
      if (value != null) {
        var js = json.decode(value);
        var token = js['access_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('login', res);
        await prefs.setString('token', token);
        if (auth.firstName == null) {
          Get.offAndToNamed(Routes.ADD_NAME_PIC_LOGIN);
        } else {
          Get.offAndToNamed(Routes.HOME);
        }
      } else {
        otpInvalid(true);
        return "invalid OTP";
      }
      loginProcess(false);
      return null;
    } else {
      otpInvalid(true);
      return "invalid";
    }
  }

  Future<String> login({String phone, String dialCode}) async {
    error = "";
    try {
      loginProcess(true);
      error = await CQAPI.login(mobile: phone, dialCode: dialCode);
      loginProcess(false);
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
  void onInactive() {}

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  validationCreateStudent(
      String name,
      String school,
      String board,
      String level,
      String phone,
      String email,
      File file,
      String dailCode) async {
    if (name.isEmpty) {
      errorMsg('full_name_required'.tr);
    } else if (name.length < 3) {
      errorMsg('full_name_min_length_error'.tr);
    } else if (name.split(' ').length <= 1) {
      print('last: $name');
      errorMsg('last_name_required'.tr);
    } else if (school.isEmpty) {
      errorMsg('school_required'.tr);
    } else if (board.isEmpty) {
      errorMsg('board_required'.tr);
    } else if (level == null) {
      errorMsg('level_required'.tr);
    }
    // else if (phone.length < 9) {
    //   errorMsg('invalid_mobile_no'.tr);
    // }
    // else  if(email.isEmpty){
    //   errorMsg('email_required'.tr);
    // }else  if(!validateEmail(email)){
    //   errorMsg('email_invalid'.tr);
    // }
    else {
      error = "";
      try {
        loginProcess(true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var response = prefs.getString('login');
        var js = json.decode(response);
        var user = AuthModel.fromJson(js);
        Student loginResp = await CQAPI.addNewChild(
          user.id,
          name,
          school,
          board,
          level,
          phone,
          email,
          dailCode,
        );
        if (loginResp != null) {
          Utils.saveImage(loginResp.id, file);
          Get.back(result: loginResp);
        }
      } finally {
        loginProcess(false);
      }
      return error;
    }
  }

  errorMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static bool validateEmail(String value) {
    var email = value.trim();
    String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(emailPattern);
    return regExp.hasMatch(email);
  }
}
