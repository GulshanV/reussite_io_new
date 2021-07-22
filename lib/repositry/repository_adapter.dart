import 'package:reussite_io_new/model/auth_model.dart';

abstract class IAuthRepository {
  Future<AuthModel> getCases();
}