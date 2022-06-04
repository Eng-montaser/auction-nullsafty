import 'package:auction/logic/controllers/register_controller.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: FCISize.height(context) * 0.6,
      // color: Colors.blue,
      child: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Container(
                  width: FCISize.width(context) * 0.75,
                  // decoration:controller.registerFocusNode==RegisterFocusNode.name
                  //     ? BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius:
                  //     BorderRadius.circular(50),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: FCIColors.shadow(),
                  //         spreadRadius: 7,
                  //         blurRadius: 10,
                  //         offset: Offset(0, 15), //
                  //       )
                  //     ])
                  //     :BoxDecoration(
                  //     color: FCIColors.accentColor(),
                  //     borderRadius:
                  //     BorderRadius.circular(50),
                  //     border: Border.all(
                  //         color: FCIColors.borderOrange()
                  //     )
                  //   // boxShadow: [
                  //   //   BoxShadow(
                  //   //     color: FCIColors.shadow(),
                  //   //     spreadRadius: 7,
                  //   //     blurRadius: 10,
                  //   //     offset: Offset(0, 15), //
                  //   //   )
                  //   // ]
                  // ),
                  child: TextFormField(
                    controller: controller.nameController,
                    focusNode: controller.focusNodeName,
                    onTap: () {
                      controller.setFocus(RegisterFocusNode.name, context);
                    },
                    onEditingComplete: () {
                      controller.setNextFocus(RegisterFocusNode.name, context);
                    },
                    validator: (v) {},
                    onSaved: (v) {},
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: controller.registerFocusNode ==
                          RegisterFocusNode.name,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FCIColors.borderOrange(), width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: InputBorder.none,
                      labelText: "name",
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: FCISize.width(context) * 0.75,
                  // decoration:controller.registerFocusNode==RegisterFocusNode.email
                  //     ? BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius:
                  //     BorderRadius.circular(50),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: FCIColors.shadow(),
                  //         spreadRadius: 7,
                  //         blurRadius: 10,
                  //         offset: Offset(0, 15), //
                  //       )
                  //     ])
                  //     :BoxDecoration(
                  //     color: FCIColors.accentColor(),
                  //     borderRadius:
                  //     BorderRadius.circular(50),
                  //     border: Border.all(
                  //         color: FCIColors.borderOrange()
                  //     )
                  //   // boxShadow: [
                  //   //   BoxShadow(
                  //   //     color: FCIColors.shadow(),
                  //   //     spreadRadius: 7,
                  //   //     blurRadius: 10,
                  //   //     offset: Offset(0, 15), //
                  //   //   )
                  //   // ]
                  // ),
                  child: TextFormField(
                    controller: controller.emailController,
                    focusNode: controller.focusNodeEmail,
                    onTap: () {
                      controller.setFocus(RegisterFocusNode.email, context);
                    },
                    onEditingComplete: () {
                      controller.setNextFocus(RegisterFocusNode.email, context);
                    },
                    validator: (v) {},
                    onSaved: (v) {},
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: controller.registerFocusNode ==
                          RegisterFocusNode.email,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FCIColors.borderOrange(), width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: InputBorder.none,
                      labelText: "email",
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: FCISize.width(context) * 0.75,
                  // decoration:controller.passwordActive? BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius:
                  //     BorderRadius.circular(50),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: FCIColors.shadow(),
                  //         spreadRadius: 7,
                  //         blurRadius: 10,
                  //         offset: Offset(0, 15), //
                  //       )
                  //     ])
                  //     :BoxDecoration(
                  //     color: FCIColors.accentColor(),
                  //     borderRadius:
                  //     BorderRadius.circular(50),
                  //     border: Border.all(
                  //         color: FCIColors.borderOrange()
                  //     )
                  //   // boxShadow: [
                  //   //   BoxShadow(
                  //   //     color: FCIColors.shadow(),
                  //   //     spreadRadius: 7,
                  //   //     blurRadius: 10,
                  //   //     offset: Offset(0, 15), //
                  //   //   )
                  //   // ]
                  // ),
                  child: TextFormField(
                    controller: controller.passwordController,
                    focusNode: controller.focusNodePassword,
                    onTap: () {
                      controller.setFocus(RegisterFocusNode.password, context);
                    },
                    onEditingComplete: () {
                      controller.setNextFocus(
                          RegisterFocusNode.password, context);
                    },
                    validator: (v) {},
                    onSaved: (v) {},
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: controller.registerFocusNode ==
                          RegisterFocusNode.password,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FCIColors.borderOrange(), width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: "password",
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: FCISize.width(context) * 0.75,
                  // decoration:controller.confirmPasswordActive? BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius:
                  //     BorderRadius.circular(50),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: FCIColors.shadow(),
                  //         spreadRadius: 7,
                  //         blurRadius: 10,
                  //         offset: Offset(0, 15), //
                  //       )
                  //     ])
                  //     :BoxDecoration(
                  //     color: FCIColors.accentColor(),
                  //     borderRadius:
                  //     BorderRadius.circular(50),
                  //     border: Border.all(
                  //         color: FCIColors.borderOrange()
                  //     )
                  //   // boxShadow: [
                  //   //   BoxShadow(
                  //   //     color: FCIColors.shadow(),
                  //   //     spreadRadius: 7,
                  //   //     blurRadius: 10,
                  //   //     offset: Offset(0, 15), //
                  //   //   )
                  //   // ]
                  // ),
                  child: TextFormField(
                    controller: controller.conPasswordController,
                    focusNode: controller.focusNodeCPassword,
                    onTap: () {
                      controller.setFocus(RegisterFocusNode.cPassword, context);
                    },
                    onEditingComplete: () {
                      controller.setNextFocus(
                          RegisterFocusNode.cPassword, context);
                    },
                    validator: (v) {},
                    onSaved: (v) {},
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: controller.registerFocusNode ==
                          RegisterFocusNode.cPassword,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FCIColors.borderOrange(), width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: "confirm password",
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
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
    );
  }
}