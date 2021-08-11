import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:reussite_io_new/model/schedule_model.dart';
class Utils{

  static errorToast(String msg){
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
  static successToast(String msg){
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

  }

  static String convertTime(String arrSlot) {
    String time = arrSlot;
    try{
      var d= time.toString().split('+')[0].trim();
      var format = DateFormat('MM/dd/yyyy HH:mm:ss').parse(d).toLocal();
      time = DateFormat('HH:mm a').format(format);
    }catch(_){
      time = arrSlot;
    }

    return time;
  }

  static String convertBookingTime(String arrSlot) {
    String time = arrSlot;
    try{
      var d= time.toString().split('+')[0].trim();
      var format = DateFormat('MM/dd/yyyy HH:mm:ss').parse(d).toLocal();
      time = DateFormat('MM/dd/yyyy HH:mm a').format(format);
    }catch(_){
      time = arrSlot;
    }

    return time;
  }
}