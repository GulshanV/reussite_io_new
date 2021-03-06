import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/image_model.dart';

class Utils {
  static errorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static successToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String convertTime(String arrSlot) {
    String time = arrSlot;
    try {
      var d = time.toString().split('+')[0].trim();
      var format = DateFormat('MM/dd/yyyy HH:mm:ss').parse(d,true).toLocal();
      time = DateFormat('hh a').format(format);
    } catch (_) {
      time = arrSlot;
    }

    return time;
  }

  static String convertBookingTime(String arrSlot) {
    String time = arrSlot;
    try {
      var d = time.toString().split('+')[0].trim();
      var format = DateFormat('MM/dd/yyyy HH:mm:ss').parse(d).toLocal();
      time = DateFormat('MM/dd/yyyy HH:mm a').format(format);
    } catch (_) {
      time = arrSlot;
    }

    return time;
  }

  static errorMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String convertChatTime(String arrSlot) {
    String time = arrSlot;
    try {
      var d = time.toString().split('+')[0].trim();
      var format = DateFormat('MM/dd/yyyy HH:mm:ss').parse(d).toLocal();
      time = DateFormat('dd.MM.yy').format(format);
    } catch (_) {
      time = arrSlot;
    }

    return time;
  }

  static Future<void> saveCountryCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('countryCode', code);
  }

  static getCountryCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('countryCode');
  }

  static Future<bool> saveAvatarImage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatarImage', value);
  }

  static Future<String> getAvatarImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('avatarImage');
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Future<void> saveImage(id, File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = prefs.getString('image');
    List<ImageModel> arrImage=[];
    if (response != null) {
      var js = json.decode(response);
      arrImage =(js as List).map((e) => ImageModel.fromJSON(e)).toList();

      arrImage.add(ImageModel(image: file.path, childId: id));


    }else{
     arrImage.add(ImageModel(image: file.path, childId: id));
    }
    List jsonList = List();
    arrImage.map((item) => jsonList.add(item.toMap())).toList();
    var value = json.encode(jsonList);
    await prefs.setString('image', value);
  }
}
