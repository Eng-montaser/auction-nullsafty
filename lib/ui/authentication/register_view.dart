import 'package:auction/logic/controllers/register_controller.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/custom_textFeild.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: FCISize.height(context) * 0.6,
      // color: Colors.blue,
      child: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  AuthTextField(
                      controller: controller.nameController,
                      focusNode: controller.focusNodeName,
                      filled:  controller.registerFocusNode ==
                          RegisterFocusNode.name,
                      onTap: () {
                        controller.setFocus(RegisterFocusNode.name, context);
                      },
                      onEditingComplete: () {
                        controller.setNextFocus(RegisterFocusNode.name, context);
                      },
                      inputType: TextInputType.text,
                      obsecure: false,
                      hintText: "Name".tr,
                      icon:Icons.person
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                      controller: controller.emailController,
                      focusNode: controller.focusNodeEmail,
                      filled:  controller.registerFocusNode ==
                          RegisterFocusNode.email,
                      onTap: () {
                        controller.setFocus(RegisterFocusNode.email, context);
                      },
                      onEditingComplete: () {
                        controller.setNextFocus(RegisterFocusNode.email, context);
                      },
                      inputType: TextInputType.emailAddress,
                      obsecure: false,
                      hintText: "Email".tr,
                      icon:Icons.email
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                      controller: controller.passwordController,
                      focusNode: controller.focusNodePassword,
                      onTap: () {
                        controller.setFocus(RegisterFocusNode.password, context);
                      },
                      onEditingComplete: () {
                        controller.setNextFocus(
                            RegisterFocusNode.password, context);
                      },
                      filled: controller.registerFocusNode ==
                          RegisterFocusNode.password,
                      inputType: TextInputType.emailAddress,
                      obsecure: true,
                      hintText: "Password".tr,
                      icon:Icons.lock
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                      controller: controller.conPasswordController,
                      focusNode: controller.focusNodeCPassword,
                      onTap: () {
                        controller.setFocus(RegisterFocusNode.cPassword, context);
                      },
                      onEditingComplete: () {
                        controller.setNextFocus(
                            RegisterFocusNode.cPassword, context);
                      },
                      filled: controller.registerFocusNode ==
                          RegisterFocusNode.cPassword,
                      inputType: TextInputType.text,
                      obsecure: false,
                      hintText: "Confirm Password".tr,
                      icon:Icons.lock
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Container(
                height: FCISize.height(context) * 0.25,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    controller.register(context);
                  },
                  child: Container(
                    width: FCISize.height(context) * 0.1,
                    height: FCISize.height(context) * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: controller.isLoading.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: FCISize.height(context) * 0.05,
                                height: FCISize.height(context) * 0.05,
                                child: CircularProgressIndicator(
                                  color: FCIColors.borderOrange(),
                                ),
                              ),
                            ],
                          )
                        : Icon(
                            Icons.arrow_forward,
                            size: ScreenUtil().setWidth(35),
                            color: FCIColors.iconGrey(),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
