import 'package:auction/ui/authentication/login_view.dart';
import 'package:auction/ui/authentication/register_view.dart';
import 'package:auction/ui/widgets/clippath.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:auction/logic/controllers/auth_controller.dart';

import '../main_view.dart';

class AuthenticationView extends GetView<AuthenticationController> {
   AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FCIColors.accentColor(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: FCIColors.primaryColor(),
              ),
              clipper: BottomClipPath(),
            ),
            Column(
              children: [
                Container(
                  height: FCISize.height(context) * 0.25,
                ),
    GetBuilder<AuthenticationController>(
    init: AuthenticationController(),
    builder: (authenticationController) => Container(
        height: FCISize.height(context) * 0.75,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        authenticationController.loginActiveChange(true);
                      },
                      child: Text(
                        "Sing in".tr,
                        style: FCITextStyle.bold(21,
                            color: FCIColors.iconGrey()),
                      ),
                    ),
                    if (authenticationController.loginActive)
                      Container(
                        width: ScreenUtil().setWidth(50),
                        child: Divider(
                          color: Colors.red,
                          thickness: 3,
                        ),
                      )
                  ],
                ),
                Container(
                    height: ScreenUtil().setHeight(20),
                    child: VerticalDivider(
                      color: FCIColors.iconGrey(),
                      thickness: 2,
                    )),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        authenticationController.loginActiveChange(false);
                      },
                      child: Text(
                        "Sing Up".tr,
                        style: FCITextStyle.bold(21,
                            color: FCIColors.iconGrey()),
                      ),
                    ),
                    if (!authenticationController.loginActive)
                      Container(
                        width: ScreenUtil().setWidth(50),
                        child: Divider(
                          color: Colors.red,
                          thickness: 3,
                        ),
                      )
                  ],
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(25),
            ),
            authenticationController.loginActive
                ? LoginView()
                : RegisterView()
          ],
        )),
    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
