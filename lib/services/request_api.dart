import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import "dart:core";
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reussite_io_new/config/ps_config.dart';

class RequestApi {

  

  static Future<String> postAsync(String endPoint, {Map<String,dynamic> body}) async {

    String fullUrl=PsConfig.baseUrl+endPoint;
    print(fullUrl);
    var header = Map<String,String>();


    try{
      return http.post(Uri.parse(fullUrl),headers: header, body:body).then((http.Response response) {
        final int statusCode = response.statusCode;
        print(statusCode);
        print(response.body);
        if (statusCode < 200 || statusCode >= 400 || json == null) {
          var js = json.decode(response.body);
          String msg='';
          final Map<String, dynamic> fruitItemMap = HashMap();
          js.forEach((name, value) {
            msg=value;
          });
          Get.showSnackbar(GetBar(message: msg,));
          return null;
        }else if(response.body==null){
          return null;
        }


        return response.body;
      });
    } catch(_) {
      print(_);
      return null;
    }


  }


  static Future<String> get(String endPoint) async {

    String fullUrl=PsConfig.baseUrl+endPoint;
    print(fullUrl);
    var header = Map<String,String>();


    try{
      return http.get(Uri.parse(fullUrl),headers: header).then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          return null;
        }else if(response.body==null){
          return null;
        }
        return response.body;
      });
    } catch(_) {
      return null;
    }
  }


}