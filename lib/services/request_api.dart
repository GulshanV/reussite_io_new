import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import "dart:core";
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reussite_io_new/config/ps_config.dart';

class RequestApi {


/*  static Future<String> postAsync(String endPoint, {Map<String,dynamic> body}) async {

    String fullUrl=PsConfig.baseUrl+endPoint;
    print('post:$fullUrl');
    print(body);
    Map<String,String> header={
      'content-type': 'application/json'
    };

    try{
      var request = await http.post(Uri.parse(fullUrl),body: json.encode(body),headers: header);

      print(request.body);
        return request.body;
    } catch(_) {
      print(_);
      return null;
    }


  }

  static Future<String> putAsync(String endPoint, {Map<String,dynamic> body}) async {

    String fullUrl=PsConfig.baseUrl+endPoint;
    print(fullUrl);
    var header = Map<String,String>();


    try{
      return http.put(Uri.parse(fullUrl),headers: header, body:body).then((http.Response response) {
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
    var headers={
      'content-type':'application/json'
    };
    try{
      var request = await http.get(Uri.parse(fullUrl),headers: headers);
      return request.body;
    } catch(_) {
      print(_);
      return null;
    }

  }*/

  static Future<String> postAsync(String endPoint, {Map<String,dynamic> body}) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String fullUrl=PsConfig.baseUrl+endPoint;
    print('post:$fullUrl');
    print(body);

    try{
      HttpClientRequest request = await client.postUrl(Uri.parse(fullUrl));

      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(body)));

      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();

      return reply;
    } catch(_) {
      print(_);
      return null;
    }


  }

  static Future<String> patch(String endPoint, {Map<String,dynamic> body}) async {

    String fullUrl=PsConfig.baseUrl+endPoint;
    print(fullUrl);
    print(body);
    var header = Map<String,String>();


    try{

      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('PATCH', Uri.parse(fullUrl));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        print(res);
        return res;
      } else {
        return response.reasonPhrase;
      }

    } catch(_) {
      print(_);
      return null;
    }


  }

  static Future<String> putAsync(String endPoint, {Map<String,dynamic> body}) async {

    String fullUrl=PsConfig.baseUrl+endPoint;
    print(fullUrl);
    var header = Map<String,String>();


    try{
      return http.put(Uri.parse(fullUrl),headers: header, body:body).then((http.Response response) {
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

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    try{
      HttpClientRequest request = await client.getUrl(Uri.parse(fullUrl));

      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();

      return reply;
    } catch(_) {
      print(_);
      return null;
    }

  }


}