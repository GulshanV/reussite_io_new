import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
      var format = DateFormat('MM/dd/yyyy HH:mm:ss').parse(d).toLocal();
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
}
