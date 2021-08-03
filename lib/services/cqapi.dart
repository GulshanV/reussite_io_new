import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reussite_io_new/services/request_api.dart';

class CQAPI {
  static var client = http.Client();


  static Future<String> login({String mobile}) async {
   String phone = mobile.replaceAll('-', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', '');
    var response = await RequestApi.get('parent/phoneNumber/$phone');
    print(response);

    return null;

  }
}