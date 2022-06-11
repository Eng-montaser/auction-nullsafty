import 'dart:convert';

import 'package:auction/database/services/post_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/models/user_model.dart';
import '../../ui/authentication/auth_view.dart';

class AuthenticationController extends GetxController {
  bool loginActive = true;
  loginActiveChange(bool value) {
    loginActive = value;
    update();
    print(loginActive);
  }

  FCIAuthUserModel? _userData;
  FCIAuthUserModel? get userData => _userData;
  saveUserData(json) async {
    _userData = FCIAuthUserModel.fromLoginJson(json);
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    String user = jsonEncode(json['user']);
    shared_User.setString('user', user);
    String token = jsonEncode(json['token']);
    shared_User.setString('token', token);
  }

  getUserData() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    var userData = shared_User.getString('user');
    var tokenData = shared_User.getString('token');
    if (tokenData !=null && userData != null) {
      Map userMap = {
        'token':jsonDecode(tokenData),
        'user':jsonDecode(userData)
      };
      if (userMap.isNotEmpty)
        _userData = FCIAuthUserModel.fromLoginJson(userMap);
    }
  }

  logOut() async {
    PostService _postService = new PostService();
    await _postService.logout().then((response) async {
      print(response.body.toString());
      if (response.statusCode == 200) {
        SharedPreferences shared_User = await SharedPreferences.getInstance();
        shared_User.remove('user');
        shared_User.remove('token');
        Get.offAll(() => AuthenticationView());
      }else{
        SharedPreferences shared_User = await SharedPreferences.getInstance();
        shared_User.remove('user');
        shared_User.remove('token');
        Get.offAll(() => AuthenticationView());
      }
    });
  }
}
