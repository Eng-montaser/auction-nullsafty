import 'package:auction/logic/controllers/change_password_controller.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
import 'package:auction/ui/widgets/profile_textfield.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatefulWidget  {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      appBar:AppBar(
        backgroundColor:FCIColors.primaryColor(),
        elevation: 0,
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().setHeight(40)),
          child: Builder(builder: (context) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: ScreenUtil().setSp(25),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text("Change Password",style: FCITextStyle.bold(22,color: Colors.white),),
                IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: ScreenUtil().setSp(35),
                  ),
                  onPressed: () {

                  },
                ),
              ],
            );
          }),
        ),
      ),
      backgroundColor: FCIColors.accentColor(),
      body: Background(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15),
              vertical:ScreenUtil().setHeight(20) ),
          width: FCISize.width(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
            GetBuilder<ChangePasswordController>(
            init: ChangePasswordController(),
              builder: (controller)   {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
                            vertical:ScreenUtil().setHeight(10) ),
                        child: Column(
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/changepassword_hader.png',
                                height: FCISize.width(context) * 0.50,
                                width: FCISize.width(context) * 0.75,
                                fit: BoxFit.fill,
                              ),
                            ),
                            ProfileTextField(
                              hintText: "Current Password",
                              obsecure: true,
                              controller: controller.currentPasswordController,
                              focusNode: controller.focusNodeCurrentPassword,
                              onTap: () {
                                controller.setFocus(ChangePasswordFocusNode.currentPassword, context);
                                print(controller.changePasswordFocusNode);
                              },
                              onEditingComplete: () {
                                controller.setNextFocus(ChangePasswordFocusNode.currentPassword, context);
                                print(controller.changePasswordFocusNode);
                              },
                            ),
                            ProfileTextField(
                              hintText: "New Password",
                              obsecure: true,
                              controller: controller.passwordController,
                              focusNode: controller.focusNodePassword,
                              onTap: () {
                                controller.setFocus(ChangePasswordFocusNode.password, context);
                              },
                              onEditingComplete: () {
                                controller.setNextFocus(ChangePasswordFocusNode.password, context);
                              },
                            ),
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
                          ],
                        ),
                      ),
                    );
                  }
                ),
                Center(
                  child: Image.asset(
                    'assets/images/auction_logo.png',
                    height: FCISize.height(context) * 0.15,
                    width: FCISize.height(context) * 0.15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}
