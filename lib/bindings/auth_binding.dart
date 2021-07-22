import 'package:get/get.dart';
import 'package:reussite_io_new/controller/auth_controller.dart';
import 'package:reussite_io_new/provider/login_provider.dart';
import 'package:reussite_io_new/repositry/auth_repositry.dart';
import 'package:reussite_io_new/repositry/repository_adapter.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthProvider>(() => AuthProvider());
    Get.lazyPut<IAuthRepository>(() => AuthRepository(provider: Get.find()));
    Get.lazyPut(() => AuthController(homeRepository: Get.find()));
  }
}