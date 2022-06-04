import 'package:flutter/material.dart';

class LoginData {
  LoginFocusNode? loginFocusNode;
  TextEditingController emailController;
  FocusNode focusNodeEmail = new FocusNode();
  // TextEditingController phoneController;
  // FocusNode focusNodePhone=new FocusNode();
  TextEditingController passwordController;
  FocusNode focusNodePassword = new FocusNode();
  LoginData({
    required this.emailController,
    // required  this.phoneController,
    required this.passwordController,
  }) {}
  // getLoginByPhoneBody() {
  //   return {
  //     "phone": phoneController.text,
  //     "password": passwordController.text,
  //   };
  // }
  getLoginByEmailBody() {
    return {
      "email": emailController.text,
      "password": passwordController.text,
    };
  }

  dispose() {
    if (emailController != null) emailController.dispose();
    // if(phoneController!=null)
    //   phoneController.dispose();
    if (passwordController != null) passwordController.dispose();
  }

  getFocusNode(context) {
    switch (loginFocusNode) {
      case LoginFocusNode.email:
        FocusScope.of(context).requestFocus(focusNodeEmail);
        break;
      // case LoginFocusNode.phone:
      //   FocusScope.of(context).requestFocus(focusNodePhone);
      //   break;
      case LoginFocusNode.password:
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case LoginFocusNode.success:
      case null:
        FocusScope.of(context).unfocus();
        break;
    }
  }
}

enum LoginFocusNode {
  // image,
  // name,
  email,
  // phone,
  password,
  // cPassword,
  success
}
