import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import "dart:core";
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reussite_io_new/config/ps_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestApi {



  static Future<String> postAsync(String endPoint, {Map<String,dynamic> body}) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);


    String fullUrl=PsConfig.baseUrl+endPoint;
    print('post:$fullUrl');
    print(body);

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token= prefs.getString('token');
      HttpClientRequest request = await client.postUrl(Uri.parse(fullUrl));

      request.headers.set('content-type', 'application/json; charset=UTF-8');

      if(token!=null)
      request.headers.set('Authorization', 'Bearer $token');


      request.add(utf8.encode(json.encode(body)));

      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();
      print(response.statusCode);
      print(reply);

      if (response.statusCode == 404) {
        return null;
      }else if(response.statusCode==500){
        return null;
      }

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


    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token= prefs.getString('token');
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      if(token!=null)
        headers['Authorization']='Bearer $token';

      print(headers);

      var request = http.Request('PATCH', Uri.parse(fullUrl));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 404) {
        return null;
      }else if (response.statusCode == 200) {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token= prefs.getString('token');
    var header = Map<String,String>();
    header['content-type']='application/json; charset=UTF-8';

    if(token!=null)
      header['Authorization']='Bearer $token';

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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token= prefs.getString('token');
      HttpClientRequest request = await client.getUrl(Uri.parse(fullUrl));
      request.headers.set('content-type', 'application/json; charset=UTF-8');
      if(token!=null)
        request.headers.set('Authorization', 'Bearer $token');
      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();

      return reply;
    } catch(_) {
      print(_);
      return null;
    }

  }


}