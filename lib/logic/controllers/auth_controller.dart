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
  }

  FCIAuthUserModel? _userData;
  FCIAuthUserModel? get userData => _userData;
  Future<void> saveUserData(json) async {
    _userData = await FCIAuthUserModel.fromLoginJson(json);
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    String user = jsonEncode(json['user']);

    await shared_User.setString('user', user);
    String token = jsonEncode(json['token']);

    await shared_User.setString('token', token);

  }

  @override
  void onInit() {
super.onInit();
setInit();
  }
setInit()async{
  SharedPreferences shared_User = await SharedPreferences.getInstance();

  bool? isfirst=await shared_User.getBool('isFirst');
  if(isfirst == null){
  loginActive=false;
  shared_User.setBool('isFirst', true);
  }else{
    loginActive=false;
  }
}
  Future<String> getUserData() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    var userData = await shared_User.getString('user');
    var tokenData =await shared_User.getString('token');
    if (tokenData !=null && userData != null) {
      Map userMap = {
        'token':jsonDecode(tokenData),
        'user':jsonDecode(userData)
      };
      if (userMap.isNotEmpty)
        _userData = FCIAuthUserModel.fromLoginJson(userMap);
    }
    return tokenData??'';
  }

  logOut() async {
    PostService _postService = new PostService();
    await _postService.logout().then((response) async {
      print(response.body.toString());
        SharedPreferences shared_User = await SharedPreferences.getInstance();
        shared_User.remove('user');
        shared_User.remove('token');
        Get.offAll(() => AuthenticationView());
    });
  }
}
