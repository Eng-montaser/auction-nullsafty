import 'dart:async';
import 'dart:convert';

import 'package:auction/database/services/post_service.dart';
import 'package:auction/ui/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/models/user_model.dart';
import '../../ui/authentication/auth_view.dart';
import '../../ui/widgets/get_message.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;
  TextEditingController currentPasswordController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController passwordConfirmationController=TextEditingController();
  FocusNode focusNodeCurrentPassword = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();
  FocusNode focusNodePasswordConfirmation = new FocusNode();
  ChangePasswordFocusNode? changePasswordFocusNode;
  getFocusNode(context) {
    switch (changePasswordFocusNode) {
      case ChangePasswordFocusNode.currentPassword:
        FocusScope.of(context).requestFocus(focusNodeCurrentPassword);
        break;
      case ChangePasswordFocusNode.password:
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case ChangePasswordFocusNode.passwordConfirmation:
        FocusScope.of(context).requestFocus(focusNodePasswordConfirmation);
        break;
      case ChangePasswordFocusNode.success:
      case null:
        FocusScope.of(context).unfocus();
        break;
    }
  }

  setFocus(focus, context) {
    changePasswordFocusNode = focus;
    getFocusNode(context);
    update();
  }

  setNextFocus(focus, context) {
    switch (focus) {
      case ChangePasswordFocusNode.currentPassword:
        changePasswordFocusNode = ChangePasswordFocusNode.password;
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case ChangePasswordFocusNode.password:
        changePasswordFocusNode = ChangePasswordFocusNode.passwordConfirmation;
        FocusScope.of(context).requestFocus(focusNodePasswordConfirmation);
        break;
      case ChangePasswordFocusNode.passwordConfirmation:
      case null:
      changePasswordFocusNode = ChangePasswordFocusNode.success;
        FocusScope.of(context).unfocus();
        break;
    }
    update();
  }
  changePassword(context) async {

    /// currentPassword empty validate
    if (currentPasswordController.text.isEmpty) {
      GetMessage('Change Password Error', "Please insert Current Password.");
      setFocus(ChangePasswordFocusNode.currentPassword, context);
      return false;
    }
    /// password empty validate
    else if (passwordController.text.isEmpty) {
      setFocus(ChangePasswordFocusNode.password, context);
      GetMessage('Change Password Error', "Please insert Password.");
      return false;
    }else if (passwordController.text.length < 6) {
      setFocus(ChangePasswordFocusNode.password, context);
      GetMessage(
          'Change Password Error', "The Password must be at least 6 characters.");
      return false;
    }
    /// Confirm password empty validate
    else if (passwordConfirmationController.text.isEmpty) {
      setFocus(ChangePasswordFocusNode.passwordConfirmation, context);
      GetMessage('Change Password Error', "Please Confirm Password.");
      return false;
    }
    /// password [6 characters] validate
      else if (passwordConfirmationController.text != passwordController.text) {
      setFocus(ChangePasswordFocusNode.passwordConfirmation, context);
      GetMessage(
          'Change Password Error', "The Password Confirmation does not match.");
      return false;
    } else {
      // late FCIAuthUserModel fciAuthUserModel;
      isLoading.value = true;
      update();
      PostService _postService = new PostService();

        await _postService.changePassword(getChangePasswordBody()).then((response) async {
          var data = jsonDecode(response.body);
          if (response.statusCode == 200) {
            GetMessage(
                'Change Password', "The Password Changed Successfully.");
            Get.offAll(() => MainScreen(), arguments: {'title': 'Home Screen'});
            isLoading.value = false;
            update();
          } else {
            print(response.body.toString());
            isLoading.value = false;
            update();
            GetMessage('Change Password', "Connection Error");
          }
        });
      // catch (e) {
      //   isLoading.value = false;
      //   update();
      //   GetMessage('Change Password', "Connection Error");
      // }
      // print('${fciAuthUserModel.user.email}');
    }
  }
  getChangePasswordBody() {
    return {
      "current_password": currentPasswordController.text,
      "password": passwordController.text,
      "password_confirmation": passwordConfirmationController.text
    };
  }
  @override
  void dispose() {
    if (currentPasswordController != null) currentPasswordController.dispose();
    if (passwordController != null) passwordController.dispose();
    if (passwordConfirmationController != null) passwordConfirmationController.dispose();
    super.dispose();
  }
  printData() {
    print(getChangePasswordBody());
  }
}
enum ChangePasswordFocusNode {
  currentPassword ,
  password ,
  passwordConfirmation ,
  success
}


/// Change Screen
/*
ProfileTextField(
                              hintText: "Confirm New Password",
                              obsecure: true,
                              controller: controller.passwordConfirmationController,
                              focusNode: controller.focusNodePasswordConfirmation,
                              onTap: () {
                                controller.setFocus(ChangePasswordFocusNode.passwordConfirmation, context);
                              },
                              onEditingComplete: () {
                                controller.setNextFocus(ChangePasswordFocusNode.passwordConfirmation, context);
                              },
                            ),
                            GreenButton(
                              title: "Save",
                              loading: controller.isLoading.value,
                              onTap: (){
                                controller.changePassword(context);
                              },
                            )
*/