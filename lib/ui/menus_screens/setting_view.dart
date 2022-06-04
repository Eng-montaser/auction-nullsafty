import 'package:auction/route/route.dart';
import 'package:auction/ui/setting_screens/change_password_view.dart';
import 'package:auction/ui/setting_screens/changephone_view.dart';
import 'package:auction/ui/setting_screens/notifications_setting_view.dart';
import 'package:auction/ui/home_screens/notifications_view.dart';
import 'package:auction/ui/setting_screens/userprofile_view.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
 import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsView extends StatefulWidget  {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                Text("Settings",style: FCITextStyle.bold(22,color: Colors.white),),
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
          child:  Container(

            margin: EdgeInsets.symmetric(
                horizontal:FCIPadding.cardMarginHorizontal,
                vertical:FCIPadding.cardMarginVertical
            ),
            width: FCISize.width(context),
            child:   Card(
              shadowColor: Colors.grey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:FCIPadding.cardMarginHorizontal,
                  vertical:FCIPadding.cardMarginVertical,),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20),
                          vertical:ScreenUtil().setHeight(20) ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/setting_hader.png',
                          height: FCISize.width(context) * 0.50,
                          width: FCISize.width(context) * 0.75,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SettingButton(
                      text: "User Profile",
                      onTap: (){
                        Get.toNamed(AppRoutes.profile);
                      },
                    ),
                    SettingButton(
                      text: "Notifications",
                      onTap: (){
                        Get.toNamed(AppRoutes.notificationsSetting);
                      },
                    ),
                    SettingButton(
                      text: "Change Password",
                      onTap: (){
                        Get.toNamed(AppRoutes.changePassword);
                      },
                    ),
                    SettingButton(
                      text: "Change Phone",
                      onTap: (){
                        Get.toNamed(AppRoutes.changePhone);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );;
  }
}
