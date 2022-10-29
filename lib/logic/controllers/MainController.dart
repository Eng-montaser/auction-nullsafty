import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  int selectedMenuItem = 1;
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
}
