import 'package:auction/logic/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthenticationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  }
}