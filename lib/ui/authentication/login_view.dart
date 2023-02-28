import 'dart:convert';
import 'package:auction/logic/controllers/login_controller.dart';
import 'package:auction/ui/authentication/googlefacebookLogin.dart';
import 'package:auction/ui/widgets/custom_textFeild.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: FCISize.height(context) * 0.6,
      // color: Colors.blue,
      child: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  AuthTextField(
                      controller: controller.emailController,
                      focusNode:  controller.focusNodeEmail,
                      filled:  controller.loginFocusNode == LoginFocusNode.email,
                      onTap:(){
                        controller.setFocus(LoginFocusNode.email, context);
                      } ,
                      onEditingComplete: (){
                        controller.setNextFocus(LoginFocusNode.email, context);
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
                    filled:  controller.loginFocusNode == LoginFocusNode.password,
                    onTap:(){
                      controller.setFocus(LoginFocusNode.password, context);
                    } ,
                    onEditingComplete: (){
                      controller.setNextFocus(LoginFocusNode.password, context);
                    },
                    inputType: TextInputType.text,
                    obsecure: true,
                    hintText: "Password".tr,
                    icon:Icons.lock
                  ),
                ],
              ),
               SizedBox(height: ScreenUtil().setHeight(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: ScreenUtil().setWidth(80),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Text('Sign In Using'.tr,style: FCITextStyle.bold(20,color: FCIColors.primaryColor()),),
                  Container(
                    width: ScreenUtil().setWidth(80),
                    child: Divider(
                        thickness: 1,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    socialButtonCircle(
                        FCIColors().facebookColor, CupertinoIcons.f_cursive,
                        iconColor: Colors.white, onTap: () {
                      controller.facebookLogin();
                    }),
                    socialButtonCircle(
                        FCIColors().googleColor, Icons.g_mobiledata,
                        iconColor: Colors.white, onTap: () {
controller.googleLogin();
                    }),

                  ],
                ),
              ),
              /*Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      GoogleDriveActions().signIn();
                     /* final result = await firebase.performGoogleSignIn();
                      if (result != null) {
                        print(result.email);
                      }*/
                    },
                    child:  Text("Signin with Google"),
                  ),
                  Text(
                    controller.userData != null ? controller.prettyPrint(controller.userData!) : "NO LOGGED",
                  ),
                  const SizedBox(height: 20),
                  controller.accessToken != null
                      ? Text(
                    controller.prettyPrint(controller.accessToken!.toJson()),
                  )
                      : Container(),
                  const SizedBox(height: 20),
                  CupertinoButton(
                    color: Colors.blue,
                    child: Text(
                      controller.userData != null ? "LOGOUT" : "LOGIN",
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: controller.userData != null ? controller.logOut1 : controller.login1,
                  ),
                ],
              ),*/
              Container(
                height: FCISize.height(context) * 0.25,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    controller.login(context);
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
  static Widget socialButtonCircle(color, icon, {iconColor, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            color: iconColor,
          )), //
    );
  }
}
