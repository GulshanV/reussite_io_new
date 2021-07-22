import 'package:flutter/material.dart';
import 'package:reussite_io_new/model/auth_model.dart';
import 'package:reussite_io_new/provider/login_provider.dart';
import 'package:reussite_io_new/repositry/repository_adapter.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({@required this.provider});
  final IAuthProvider provider;

  @override
  Future<AuthModel> getCases() async {
    final cases = await provider.getCases("/summary");
    if (cases.status.hasError) {
      return Future.error(cases.statusText);
    } else {
      return cases.body;
    }
  }
}