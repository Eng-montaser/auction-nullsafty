import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../database/services/post_service.dart';
import '../../ui/main_view.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  LoginFocusNode? loginFocusNode;
  FocusNode focusNodeEmail = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();
  getSignInBody() {
    // return {
    //   "app_secret": "app_secret",
    //   "name": nameController.text,
    //   "phone": phoneController.text,
    //   "email": emailController.text,
    //   "password": passwordController.text,
    // };
    return {
      "email": emailController.text,
      "password": passwordController.text,
    };
  }

  getFocusNode(context) {
    switch (loginFocusNode) {
      case LoginFocusNode.email:
        FocusScope.of(context).requestFocus(focusNodeEmail);
        break;
      case LoginFocusNode.password:
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case LoginFocusNode.success:
      case null:
        FocusScope.of(context).unfocus();
        break;
    }
  }

  setFocus(focus, context) {
    loginFocusNode = focus;
    getFocusNode(context);
    update();
  }

  setNextFocus(focus, context) {
    switch (focus) {
      case LoginFocusNode.email:
        loginFocusNode = LoginFocusNode.password;
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case LoginFocusNode.password:
      case null:
        loginFocusNode = LoginFocusNode.success;
        FocusScope.of(context).unfocus();
        break;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    if (emailController != null) emailController.dispose();
    if (passwordController != null) passwordController.dispose();
    super.dispose();
  }

  printData() {
    print(getSignInBody());
  }

  bool emailIsValid(String email) {
    return GetUtils.isEmail(email);
  }
// register()async{
//   if()
// }

  login(context) async {
    /// email empty validate
    if (emailController.text.isEmpty) {
      Get.snackbar('Login Error', "Please insert Email.");
      setFocus(LoginFocusNode.email, context);
      return false;
    }

    /// name Valid validate
    else if (!emailIsValid(emailController.text)) {
      setFocus(LoginFocusNode.email, context);
      Get.snackbar('Login Error', "Please insert a Valid Email.");
      return false;
    }

    /// password empty validate
    else if (passwordController.text.isEmpty) {
      setFocus(LoginFocusNode.password, context);
      Get.snackbar('Login Error', "Please insert Password.");
      return false;
    }

    /// password [6 characters] validate
    else if (passwordController.text.length < 6) {
      setFocus(LoginFocusNode.password, context);
      Get.snackbar(
          'Login Error', "The Password must be at least 6 characters.");
      return false;
    } else {
      // late FCIAuthUserModel fciAuthUserModel;
      isLoading.value = true;
      update();
      PostService _postService = new PostService();
      //print(getSignInBody());
      try {
        await _postService.login(getSignInBody()).then((response) async {
          var data = jsonDecode(response.body);
          if (response.statusCode == 200) {
            AuthenticationController _authController =
                Get.put(AuthenticationController());
            await _authController.saveUserData(data);
            Get.to(() => MainScreen(), arguments: {'title': 'Home Screen'});
            isLoading.value = false;
            update();
          } else {
            print(response.statusCode);
            isLoading.value = false;
            update();
            Get.snackbar('Login Error', "error");
          }
        });
      } catch (e) {
        isLoading.value = false;
        update();
        Get.snackbar('Login Error', "error");
      }
      update();
      // print('${fciAuthUserModel.user.email}');
    }
  }
}

enum LoginFocusNode {
  // image,
  email,
  // phone,
  password,
  success
}
