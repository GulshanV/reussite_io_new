import 'package:get/get.dart';
import 'package:reussite_io_new/model/auth_model.dart';

// ignore: one_member_abstracts
abstract class IAuthProvider {
  Future<Response<AuthModel>> getCases(String path);
}

class AuthProvider extends GetConnect implements IAuthProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder = (val) => AuthModel.fromJson(val as Map<String, dynamic>);
    httpClient.baseUrl = 'https://api.covid19api.com';
  }

  @override
  Future<Response<AuthModel>> getCases(String path) => get(path);
}