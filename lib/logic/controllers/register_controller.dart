import 'dart:convert';

import 'package:auction/database/services/post_service.dart';
import 'package:auction/logic/controllers/auth_controller.dart';
import 'package:auction/ui/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController conPasswordController = new TextEditingController();

  RegisterFocusNode? registerFocusNode;
  FocusNode focusNodeName = new FocusNode();
  FocusNode focusNodeEmail = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();
  FocusNode focusNodeCPassword = new FocusNode();
  getSignUpBody() {
    // return {
    //   "app_secret": "app_secret",
    //   "name": nameController.text,
    //   "phone": phoneController.text,
    //   "email": emailController.text,
    //   "password": passwordController.text,
    // };
    return {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };
  }

  getFocusNode(context) {
    switch (registerFocusNode) {
      // case RegisterFocusNode.image:
      //   FocusScope.of(context).unfocus();
      //   break;
      case RegisterFocusNode.name:
        FocusScope.of(context).requestFocus(focusNodeName);
        break;
      case RegisterFocusNode.email:
        FocusScope.of(context).requestFocus(focusNodeEmail);
        break;
      // case AuthFocusNode.phone:
      //   FocusScope.of(context).requestFocus(focusNodePhone);
      //   break;
      case RegisterFocusNode.password:
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case RegisterFocusNode.cPassword:
        FocusScope.of(context).requestFocus(focusNodeCPassword);
        break;
      case RegisterFocusNode.success:
      case null:
        FocusScope.of(context).unfocus();
        break;
    }
  }

  setFocus(focus, context) {
    registerFocusNode = focus;
    getFocusNode(context);
    update();
  }

  setNextFocus(focus, context) {
    switch (focus) {
      case RegisterFocusNode.name:
        registerFocusNode = RegisterFocusNode.email;
        FocusScope.of(context).requestFocus(focusNodeEmail);
        break;
      case RegisterFocusNode.email:
        registerFocusNode = RegisterFocusNode.password;
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case RegisterFocusNode.password:
        registerFocusNode = RegisterFocusNode.cPassword;
        FocusScope.of(context).requestFocus(focusNodeCPassword);
        break;
      case RegisterFocusNode.cPassword:
      case null:
        registerFocusNode = RegisterFocusNode.success;
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
    if (nameController != null) nameController.dispose();
    // if(phoneController!=null)
    //   phoneController.dispose();
    if (passwordController != null) passwordController.dispose();
    if (conPasswordController != null) conPasswordController.dispose();
    super.dispose();
  }

  printData() {
    print(getSignUpBody());
  }

  bool emailIsValid(String email) {
    return GetUtils.isEmail(email);
  }

  register(context) async {
    /// name empty validate
    if (nameController.text.isEmpty) {
      setFocus(RegisterFocusNode.name, context);
      Get.snackbar('Registration Error', "Please insert username.");
      return false;
    }

    /// email empty validate
    else if (emailController.text.isEmpty) {
      setFocus(RegisterFocusNode.email, context);
      Get.snackbar('Registration Error', "Please insert Email.");
      return false;
    }

    /// name Valid validate
    else if (!emailIsValid(emailController.text)) {
      setFocus(RegisterFocusNode.email, context);
      Get.snackbar('Registration Error', "Please insert a Valid Email.");
      return false;
    }

    /// password empty validate
    else if (passwordController.text.isEmpty) {
      setFocus(RegisterFocusNode.password, context);
      Get.snackbar('Registration Error', "Please insert Password.");
      return false;
    }

    /// password [6 characters] validate
    else if (passwordController.text.length < 6) {
      setFocus(RegisterFocusNode.password, context);
      Get.snackbar(
          'Registration Error', "The Password must be at least 6 characters.");
      return false;
    }

    /// Confirm Password  validate
    else if (conPasswordController.text != passwordController.text) {
      setFocus(RegisterFocusNode.cPassword, context);
      Get.snackbar(
          'Registration Error', "The Password Confirmation does not match.");
      return false;
    } else {
      isLoading.value = true;
      PostService _postService = new PostService();
      //  print(getSignUpBody());
      try {
        await _postService.register(getSignUpBody()).then((value) async {
          // print(value.body.toString());
          isLoading.value = false;
          AuthenticationController _authController =
              Get.put(AuthenticationController());
          var data = jsonDecode(value.body);

          await _authController.saveUserData(data);
          Get.to(() => MainScreen(), arguments: {'title': 'Home Screen'});
          isLoading.value = false;
          update();
        });
      } catch (e) {
        isLoading.value = false;
        update();
        Get.snackbar('Registration Error', "error");
      }
      update();
    }
  }
}

enum RegisterFocusNode {
  // image,
  name,
  email,
  // phone,
  password,
  cPassword,
  success
}
