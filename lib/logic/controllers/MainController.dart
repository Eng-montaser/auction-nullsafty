import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  int selectedMenuItem = 0;
  changeSideBar(context) {
    if (isDrawerOpen) {
      xOffset = 0;
      yOffset = 0;
      isDrawerOpen = false;
    } else {
      xOffset = Get.locale == Locale('en', 'US')
          ?  ScreenUtil().setWidth(100)
          : -ScreenUtil().setWidth(120);
      yOffset = ScreenUtil().setHeight(110);
      isDrawerOpen = true;
    }
    update();
  }

  changeMenuItem(int index) {
    selectedMenuItem = index;
    update();
  }
  updateLanguage() async {
    if (Get.locale?.languageCode == "en") {
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      shared_User.setString( 'locale',  'ar');
      // Get.locale = null;
      await Get.updateLocale(Locale('ar', 'EG'));
    } else {
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      shared_User.setString( 'locale',  'en');
//
      await Get.updateLocale(Locale('en', 'US'));
    }
    //deleting all controllers// Restarting app

    // RestartWidget.restartApp(context);
  }

}
